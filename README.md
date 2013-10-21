# E-Shelf

[![Build Status](https://travis-ci.org/NYULibraries/eshelf.png?branch=master)](https://travis-ci.org/NYULibraries/eshelf)
[![Dependency Status](https://gemnasium.com/NYULibraries/eshelf.png)](https://gemnasium.com/NYULibraries/eshelf)
[![Code Climate](https://codeclimate.com/github/NYULibraries/eshelf.png)](https://codeclimate.com/github/NYULibraries/eshelf)
[![Coverage Status](https://coveralls.io/repos/NYULibraries/eshelf/badge.png?branch=master)](https://coveralls.io/r/NYULibraries/eshelf)


The e-Shelf application at NYU provides a mechanism for cross system set management.  
It leverages the [acts_as_citable gem](/NYULibraries/acts_as_citable) to normalize data from
a variety of external systems such as Primo and Xerxes.

## External System Support
E-Shelf currently supports the following external systems:

- Primo
- Xerxes

In the future, e-Shelf plans to support

- GetIt (coming soon)
- Finding Aids Search
- EDS

## Features
- [CORS JavaScript API](/NYULibraries/eshelf/wiki/CORS-JavaScript-API) for external systems
- Standard Send/Share options based on the [ex_cite gem](/NYULibraries/ex_cite)
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
