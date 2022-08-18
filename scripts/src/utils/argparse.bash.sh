#!/usr/bin/env bash
set -eou pipefail

# Use python's argparse module in shell scripts
#
# The function `argparse` parses its arguments using
# argparse.ArgumentParser; the parser is defined in the function's
# stdin.
#
# Executing ``argparse.bash`` (as opposed to sourcing it) prints a
# script template.
ARGPARSE_DESCRIPTION="kube-core scripts
At the moment, all flags are optional and shared by all scripts.
Each script may implement some of the args."

argparse(){
    argparser=$(mktemp 2>/dev/null || mktemp -t argparser)
    cat > "$argparser" <<EOF
from __future__ import print_function
import sys
import argparse
import os


class MyArgumentParser(argparse.ArgumentParser):
    def print_help(self, file=None):
        """Print help and exit with error"""
        super(MyArgumentParser, self).print_help(file=file)
        sys.exit(1)

parser = MyArgumentParser(prog=os.path.basename("$0"),
            # preserve newlines in description
            formatter_class=argparse.RawDescriptionHelpFormatter,
            description="""$ARGPARSE_DESCRIPTION""")

parser.add_argument('--dry-run', help='Simulates running the script, if applicable')
parser.add_argument('-kl', '--kubernetes-selector', help='Selects resources with kubectl labels, if applicable')
parser.add_argument('-hl', '--helmfile-selector', help='Quickly adds a helmfile label selector')
parser.add_argument('-hlo', '--helmfile-selector-override', help='Allows full control on sending labels to Helmfile. Requires to specify -l in hl')
parser.add_argument('--force', help='Forces actions, if applicable')
parser.add_argument('-o', '--output', help='Output format, if applicable')
parser.add_argument('-f', '--file', help='Inputs a file, if applicable')
parser.add_argument('--filter', help='Filters processing, if applicable')
parser.add_argument('--include-secrets', default=False, help='Includes secrets. Use --no-secrets to exclude them', action=argparse.BooleanOptionalAction)
parser.add_argument('--include-crds', default=False, help='Includes CRDs. Use --no-crds to exclude them', action=argparse.BooleanOptionalAction)
parser.add_argument('--flux-managed', default=False, help='If resource is manged by flux, adds --field-manager=flux-client-side-apply to kubectl operations.', action=argparse.BooleanOptionalAction)
parser.add_argument('--helmfile-repos', default=False, help='If true, will update Helm repos (through helmfile repos)', action=argparse.BooleanOptionalAction)



args = parser.parse_args()
for arg in [a for a in dir(args) if not a.startswith('_')]:
    key = arg.upper()
    value = getattr(args, arg, None)

    if isinstance(value, bool) or value is None:
        print('{0}="{1}";'.format(key, 'yes' if value else ''))
    elif isinstance(value, list):
        print('{0}=({1});'.format(key, ' '.join('"{0}"'.format(s) for s in value)))
    else:
        print('{0}="{1}";'.format(key, value))


EOF

    # Define variables corresponding to the options if the args can be
    # parsed without errors; otherwise, print the text of the error
    # message.
    if python "$argparser" "$@" &> /dev/null; then
        eval $(python "$argparser" "$@")
        retval=0
    else
        python "$argparser" "$@"
        retval=1
    fi

    rm "$argparser"
    return $retval
}

# print a script template when this script is executed
if [[ $0 == *argparse.bash ]]; then
    cat <<FOO
#!/usr/bin/env bash

source \$(dirname \$0)/argparse.bash || exit 1
argparse "\$@" <<EOF || exit 1
parser.add_argument('infile')
parser.add_argument('-o', '--outfile')

EOF

echo "INFILE: \${INFILE}"
echo "OUTFILE: \${OUTFILE}"
FOO
fi


check_args() {

    # Shared custom parsing logic for all commands
    # TODO: Split it. Now it's easier to share parsing but not a best practice
    argparse "$@" || exit 1 


    kubectlArgs=""
    if [[ ! -z "${DRY_RUN}" ]]; then

        if [[ "${DRY_RUN}" == "client" || "${DRY_RUN}" == "server" ]]; then
            kubectlArgs="--dry-run=${DRY_RUN}"
        else
            log_error "--dry-run value can only be: client, server"
            exit 1
        fi
    fi

    # Default values for input arguments
    filter=""
    if [[ ! -z "${FILTER}" ]]; then
        filter="${FILTER}"
    fi

    helmfileSelector=""
    if [[ ! -z "${HELMFILE_SELECTOR}" ]]; then
        helmfileSelector="${HELMFILE_SELECTOR}"
    fi

    helmfileSelectorOverride=""
    if [[ ! -z "${HELMFILE_SELECTOR_OVERRIDE}" ]]; then
        helmfileSelectorOverride="${HELMFILE_SELECTOR_OVERRIDE}"
    fi

    includeSecrets=""
    if [[ ! -z "${INCLUDE_SECRETS}" ]]; then
        includeSecrets="${INCLUDE_SECRETS}"
    fi

    includeCRDs=""
    if [[ ! -z "${INCLUDE_CRDS}" ]]; then
        includeCRDs="${INCLUDE_CRDS}"
    fi

    fluxManaged=""
    if [[ ! -z "${FLUX_MANAGED}" ]]; then
        fluxManaged="${FLUX_MANAGED}"
    fi

    if [[ "${fluxManaged}" == "true" || "${fluxManaged}" == "yes" ]]; then
        fluxManaged="--field-manager=flux-client-side-apply"
    fi

    helmfileRepos=""
    if [[ ! -z "${HELMFILE_REPOS}" ]]; then
        helmfileRepos="${HELMFILE_REPOS}"
    fi

}