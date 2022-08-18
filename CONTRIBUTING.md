<!-- omit in toc -->
# Contributing to kube-core

***First off, thanks for taking the time to contribute!*** ❤️

We love your input! We want to make contributing to this project as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

> **All types of contributions are encouraged and valued.** 

See the [Table of Contents](#table-of-contents) for different ways to help and details about how this project handles them. Please make sure to read the relevant section before making your contribution. It will make it a lot easier for us maintainers and smooth out the experience for all involved. The community looks forward to your contributions. 🎉

> And if you like the project, but just don't have time to contribute, that's fine. There are other easy ways to support the project and show your appreciation, which we would also be very happy about:
> - Star the project
> - Tweet about it
> - Refer this project in your project's readme
> - Mention the project at local meetups and tell your friends/colleagues

<!-- omit in toc -->
## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [I Have a Question](#i-have-a-question)
- [Our Development Process](#our-development-process)
- [We use GitHub Flow](#we-use-github-flow)
- [I Want To Contribute](#i-want-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Enhancements](#suggesting-enhancements)
- [Issue Triage](#issue-triage)
- [Stability](#stability)
  - [Your First Code Contribution](#your-first-code-contribution)
  - [Improving The Documentation](#improving-the-documentation)
- [Styleguides](#styleguides)
  - [Code](#code)
  - [Commit Messages](#commit-messages)
- [Join The Project Team](#join-the-project-team)
- [License](#license)


## Code of Conduct

This project and everyone participating in it is governed by this
[Code of Conduct](./CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report unacceptable behavior
to .


## I Have a Question

> If you want to ask a question, we assume that you have read the available [Documentation](./common/docs/README.md).

Before you ask a question, it is best to search for existing [Issues](TODO) that might help you. In case you have found a suitable issue and still need clarification, you can write your question in this issue. \
It is also advisable to search the internet for answers first.

If you then still feel the need to ask a question and need clarification, we recommend the following:

- Open an [Issue](TODO/new).
- Provide as much context as you can about what you're running into.
- Provide project and platform versions (nodejs, npm, etc), depending on what seems relevant.
- Use the `question` tag

We will then take care of the issue as soon as possible.

<!--
TODO: Issue tag for questions, tell people to use it

TODO: 
- Slack
- Stack Overflow tag
- Blog
- FAQ
- Roadmap
-->


## Our Development Process
We use GitHub to sync code to and from our internal repository. 
We use GitHub to track issues and feature requests, as well as accept pull requests.


## We use [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
> **All Code Changes Happen Through Pull Requests**

We use GitHub Flow. \
We actively welcome your pull requests:

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Follow the PR guide (TODO)
6. Issue that pull request!

The main concepts behind this flow are:
- Anything in the `main` branch is deployable
- To work on something new, create a descriptively named branch off of `main` (i.e: new-awesome-feature)
- Commit to that branch locally and regularly push your work to the same named branch on the server
- When you need feedback or help, or you think the branch is ready for merging, open a pull request
- After someone else has reviewed and signed off on the feature, you can merge it into `main`
- Once it is merged and pushed to `main`, you can and should deploy immediately


## I Want To Contribute

### Any contributions you make will be under the MIT Software License <!-- omit in toc -->
In short, when you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project. Feel free to contact the maintainers if that's a concern.


> ### Legal Notice <!-- omit in toc -->
> When contributing to this project, you must agree that you have authored 100% of the content, that you have the necessary rights to the content and that the content you contribute may be provided under the project license.


### Reporting Bugs

<!-- omit in toc -->
#### Before Submitting a Bug Report

A good bug report shouldn't leave others needing to chase you up for more information. Therefore, we ask you to investigate carefully, collect information and describe the issue in detail in your report. Please complete the following steps in advance to help us fix any potential bug as fast as possible.

- Make sure that you are using the latest version.
- Determine if your bug is really a bug and not an error on your side e.g. using incompatible environment components/versions (Make sure that you have read the [documentation](). If you are looking for support, you might want to check [this section](#i-have-a-question)).
- To see if other users have experienced (and potentially already solved) the same issue you are having, check if there is not already a bug report existing for your bug or error in the [bug tracker](=label%3Abug).
- Also make sure to search the internet (including Stack Overflow) to see if users outside of the GitHub community have discussed the issue.
- Collect information about the bug:
- Stack trace (Traceback)
- OS, Platform and Version (Windows, Linux, macOS, x86, ARM)
- Version of the interpreter, compiler, SDK, runtime environment, package manager, depending on what seems relevant.
- Possibly your input and the output
- Can you reliably reproduce the issue? And can you also reproduce it with older versions?

<!-- omit in toc -->
#### How Do I Submit a Good Bug Report?

> You must never report security related issues, vulnerabilities or bugs including sensitive information to the issue tracker, or elsewhere in public. Instead sensitive bugs must be sent by email to .
<!-- TODO: Add PGP Key -->

We use GitHub issues to track bugs and errors. If you run into an issue with the project:

- Open an [Issue](/new). (Since we can't be sure at this point whether it is a bug or not, we ask you not to talk about a bug yet and not to label the issue.)
- Explain the behavior you would expect and the actual behavior.
- Please provide as much context as possible and describe the *reproduction steps* that someone else can follow to recreate the issue on their own. This usually includes your code. For good bug reports you should isolate the problem and create a reduced test case.
- Provide the information you collected in the previous section.

Once it's filed:

- The project team will label the issue accordingly.
- A team member will try to reproduce the issue with your provided steps. If there are no reproduction steps or no obvious way to reproduce the issue, the team will ask you for those steps and mark the issue as `needs-repro`. Bugs with the `needs-repro` tag will not be addressed until they are reproduced.
- If the team is able to reproduce the issue, it will be marked `needs-fix`, as well as possibly other tags (such as `critical`), and the issue will be left to be [implemented by someone](#your-first-code-contribution).

<!-- TODO: Issue Template for Bug Report and include it here -->


### Suggesting Enhancements

This section guides you through submitting an enhancement suggestion for kube-core, **including completely new features and minor improvements to existing functionality**. Following these guidelines will help maintainers and the community to understand your suggestion and find related suggestions.

<!-- omit in toc -->
#### Before Submitting an Enhancement

- Make sure that you are using the latest version.
- Read the [documentation]() carefully and find out if the functionality is already covered, maybe by an individual configuration.
- Perform a [search]() to see if the enhancement has already been suggested. If it has, add a comment to the existing issue instead of opening a new one.
- Find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. Keep in mind that we want features that will be useful to the majority of our users and not just a small subset. If you're just targeting a minority of users, consider writing an add-on/plugin library.

<!-- omit in toc -->
#### How Do I Submit a Good Enhancement Suggestion?

Enhancement suggestions are tracked as [GitHub issues]().

- Use a **clear and descriptive title** for the issue to identify the suggestion.
- Provide a **step-by-step description of the suggested enhancement** in as many details as possible.
- **Describe the current behavior** and **explain which behavior you expected to see instead** and why. At this point you can also tell which alternatives do not work for you.
- You may want to **include screenshots and animated GIFs** which help you demonstrate the steps or point out the part which the suggestion is related to. You can use [this tool](https://www.cockos.com/licecap/) to record GIFs on macOS and Windows, and [this tool](https://github.com/colinkeenan/silentcast) or [this tool](https://github.com/GNOME/byzanz) on Linux. 
- **Explain why this enhancement would be useful** to most kube-core users. You may also want to point out the other projects that solved it better and which could serve as inspiration.


<!-- TODO: Issue Template for Enhancement and include it here -->

## Issue Triage
Here are some tags that we're using to better organize issues in this repo:

good first issue - Good candidates for someone new to the project to contribute.
help wanted - Issues that should be addressed and which we would welcome a PR for but may need significant investigation or work
support - Request for help with a concept or piece of code but this isn't an issue with the project.
needs more info - Missing repro steps or context for both project issues & support questions.
discussion - Issues where folks are discussing various approaches & ideas.
question - Something that is a question specifically for the maintainers such as this issue about the license.
documentation - Relating to improving documentation for the project.
Tool specific tags (e.g. helm, helm-diff, helmfile, docker, and so on).


## Stability
Our philosophy regarding API changes is as follows:
- We will avoid changing APIs and core behaviors in general
- In order to avoid stagnation we will allow for API changes in cases where there is no other way to achieve a high priority bug fix or improvement.
- When there is an API change:
  - Changes will have a well documented reason and migration path
  - When deprecating a pattern, these steps will be followed:
    - We will test the change internally first
    - A version will be released that supports both, with deprecation warnings
    - The following version will fully remove the deprecated pattern




### Your First Code Contribution
<!-- TODO
include Setup of env, IDE and typical getting started instructions?

-->

### Improving The Documentation
<!-- TODO
Updating, improving and correcting the documentation

-->

## Styleguides
### Code
### Commit Messages
<!-- TODO

-->

## Join The Project Team
<!-- TODO -->


## License
By contributing, you agree that your contributions will be licensed under its MIT License.
