import { fileURLToPath } from 'url';
import path, { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// console.log(path.join(`${__dirname}`, `./core/envs/default/core/releases/schema.yaml`))
// process.exit()
// console.log(path.join(`${__dirname}`, `./core/releases/vendir-releases.yaml`))
export default function (plop) {
	// Release Generator

    // Adds Handlebars helper to display raw stuff
    plop.setHelper('raw', function(options) {
        return options.fn(this);
    });

    // Creates Generator for Charts
	plop.setGenerator('chart', {
		description: 'Adds a chart to kube-core',

        prompts: getExternalChartQuestions(),

		actions: function (data) {
            let actions = []

            actions = getExternalChartActions()

            console.log(JSON.stringify(data))
            return actions
        }
	});



    // Creates Generator for Releases
	plop.setGenerator('release', {
		description: 'Adds a release to kube-core',

        prompts: getExternalReleaseQuestions(),

		actions: function (data) {
            let actions = []

            actions = getExternalReleaseActions()

            console.log(JSON.stringify(data))
            return actions
        }
	});




    // Creates Generator for Scripts
	plop.setGenerator('core-script', {
		description: 'Adds a core script to kube-core',

        prompts: getCoreScriptQuestions(),

		actions: function (data) {
            let actions = []

            actions = getCoreScriptActions()

            console.log(JSON.stringify(data))
            return actions
        }
	});



    // Creates Generator for Scripts
	plop.setGenerator('cluster-script', {
		description: 'Adds a cluster script to kube-core',

        prompts: getClusterScriptQuestions(),

		actions: function (data) {
            let actions = []

            actions = getClusterScriptActions()

            console.log(JSON.stringify(data))
            return actions
        }
	});


    // Creates Generator for Releases
    // TODO: Find why this doesn't work
    // Probably because of the async prompts, data in actions function is empty
    // https://github.com/plopjs/plop/issues/81#issuecomment-764905293
    //
	// plop.setGenerator('release', {
	// 	description: 'Adds a release to kube-core',
    //     // Re-implementing async prompt loop in order to inject conditions
    //     async prompts(inquirer) {
    //         let promptQueue = [];
    //         let allAnswers = {};

    //         // First question to start working
    //         promptQueue.push(releaseTypeQuestion);

    //         // Looping through the dynamic queue
    //         while (promptQueue.length > 0) {
    //             const nextPrompt = promptQueue.shift();
    //             const nextAnswer = await inquirer.prompt(nextPrompt);

    //             // Conditional logic to add questions
    //             if(nextAnswer.releaseType == "external"){
    //                promptQueue.push(getExternalReleaseQuestions());
    //             }

    //             // Keeping track of all the answers through the loop
    //             allAnswers = {...allAnswers, ...nextAnswer};
    //          }

    //          return promptQueue
    //     },

	// 	actions: function (data) {
    //         let actions = []
    //         console.log(data)

    //         // Triggering actions depending on values in answers
    //         if(data.releaseType == 'external') {
    //             actions.push(getExternalReleaseActions(data))
    //         }

    //         return actions
    //     }
	// });

};

function getCoreScriptQuestions() {
    return [
        scriptPathQuestion,
        scriptNameQuestion,
        scriptDescriptionQuestion,
    ]
}
function getClusterScriptQuestions() {
    return [
        scriptPathQuestion,
        scriptNameQuestion,
        scriptDescriptionQuestion,
    ]
}

function getCoreScriptActions(data) {
    return [
        appendScriptToScriptConfigAction,
        addCoreScriptFileAction,
    ]
}

function getClusterScriptActions(data) {
    return [
        appendScriptToScriptConfigAction,
        addClusterScriptFileAction,
    ]
}


function getExternalReleaseQuestions() {
    return [
        chartNameQuestion,
        releaseNameQuestion,
        releaseNamespaceQuestion,
    ]
}


function getExternalReleaseActions(data) {
    return [
        appendReleaseToSchemaAction,
        addReleaseValuesFileAction,
        appendReleaseAction,
    ]
}


function getExternalChartQuestions() {
    return [
        chartRepositoryQuestion,
        chartNameQuestion,
        chartVersionQuestion
    ]
}

function getExternalChartActions(data) {
    return [
        appendVendirBaseChartAction,
    ]
}

const appendScriptToScriptConfigAction = {
    type: "append",
    path: path.join(`${__dirname}`, `./scripts/scripts-config.yaml`),
    templateFile: "plop-templates/scripts-config-entry.hbs"
}

const addCoreScriptFileAction = {
    type: "add",
    path: path.join(`${__dirname}`, `./scripts/{{ scriptPath }}`),
    templateFile: "plop-templates/core-script.hbs"
}

const addClusterScriptFileAction = {
    type: "add",
    path: path.join(`${__dirname}`, `./scripts/{{ scriptPath }}`),
    templateFile: "plop-templates/cluster-script.hbs"
}

const appendReleaseToSchemaAction = {
    type: 'append',
    path: path.join(`${__dirname}`, `./core/envs/default/core/releases/schema.yaml`),
    // pattern: /\# RELEASE/,
    templateFile: 'plop-templates/release-schema-entry.hbs'
}

const addReleaseValuesFileAction = {
    type: 'add',
    path: path.join(`${__dirname}`, `./core/values/{{ releaseName }}.yaml.gotmpl`),
    templateFile: 'plop-templates/release-values.hbs'
}

const appendVendirBaseChartAction = {
    type: 'append',
    path: path.join(`${__dirname}`, `./vendir-releases.yaml`),
    pattern: /\# Base Releases/,
    templateFile: 'plop-templates/vendir-base-release.hbs'
}

const appendReleaseAction = {
    type: 'append',
    path: path.join(`${__dirname}`, `./core/envs/default/core/releases/releases.yaml`),
    templateFile: 'plop-templates/release.hbs'
}

const scriptNameQuestion = {
    type: 'input',
    name: 'scriptName',
    message: 'Script name',
    required: true
}

const scriptPathQuestion = {
    type: 'input',
    name: 'scriptPath',
    message: 'Relative script path from kube-core /scripts folder (please include at the start "./").',
    required: true
}

const scriptDescriptionQuestion = {
    type: 'input',
    name: 'scriptDescription',
    message: 'Script description',
    required: true
}

const releaseNameQuestion = {
    type: 'input',
    name: 'releaseName',
    message: 'Release name (in kube-core)',
    required: true
}

const releaseNamespaceQuestion = {
    type: 'input',
    name: 'releaseNamespace',
    message: 'Release namespace',
    required: true
}

const chartRepositoryQuestion = {
    type: 'input',
    name: 'chartRepository',
    message: 'Helm repository URL for the chart',
    required: true
}

const chartNameQuestion = {
    type: 'input',
    name: 'chartName',
    message: 'Helm Chart name',
    required: true
}

const chartVersionQuestion = {
    type: 'input',
    name: 'chartVersion',
    message: 'Chart version to fetch',
    default: 'latest'
}

const releaseTypeQuestion = {
    type: 'list',
    name: 'releaseType',
    message: 'Choose a release type',
    choices: ["external"]
}
