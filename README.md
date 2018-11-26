# E-Shelf

[![CircleCI](https://circleci.com/gh/NYULibraries/eshelf.svg?style=svg)](https://circleci.com/gh/NYULibraries/eshelf)
[![Code Climate](https://codeclimate.com/github/NYULibraries/eshelf.png)](https://codeclimate.com/github/NYULibraries/eshelf)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/eshelf/badge.svg?branch=master)](https://coveralls.io/github/NYULibraries/eshelf?branch=master)

The e-Shelf application at NYU provides a mechanism for cross system set management.  

## External System Support
E-Shelf currently supports the following external systems:

- Primo
- Xerxes
  - New records can't be created from Xerxes anymore but existing records will continue to link out to their OpenURLs

## Features
- [CORS JavaScript API](../../wiki/CORS-JavaScript-API) for external systems
- Standard Send/Share options based on the [Citero gem](/NYULibraries/citero)
- Labels
- Brief, medium and full records emailing and printing
- Import Aleph account via an iframe

## Roadmap
- Add [CSL](http://citationstyles.org/) export options for Chicago, MLA and APA
- Support OpenURL external systems
- Support EAD external systems
- Aleph integration
  - display Aleph account natively in e-Shelf
  - allow renewal of Aleph materials natively in e-Shelf
- Improve usability
  - Icons for e-Shelf actions on mobile platforms
- Improve Wiki documentation
- Increase testing coverage
- Improve code quality
