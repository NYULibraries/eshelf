# E-Shelf Decorators
E-Shelf Decorators allow for presentation logic to be included in a DRY way.

## Record Decorators
Several Record decorators are available for adding view specific attributes to 
records. They are designed to be instantiated through convenience methods on the module
`RecordDecorator` and take an optional controller as an argument.

`EmailDecorator` and `PrintDecorator` are made available via the 
convenience methods `RecordDecorator.email` and `RecordDecorator.print`. 
These convenience methods ensure that decorator nesting works as expected.

Usage:

    email_format = "brief"
    emailable_record = RecordDecorator.email(Record.first, email_format)

    print_format = "brief"
    printable_record = RecordDecorator.print(Record.first, print_format)

or in the RecordsHelper (where we have a view context)

    email_format = "medium"
    emailable_record = RecordDecorator.email(Record.first, self, email_format)

    print_format = "medium"
    printable_record = RecordDecorator.print(Record.first, self, print_format)

or in the RecordsMailer (where we also have a view context)

    email_format = "full"
    emailable_record = RecordDecorator.email(Record.first, self, email_format)

    print_format = "full"
    printable_record = RecordDecorator.print(Record.first, self, print_format)

Additional Record decorators are `ArticleDecorator`, `CitationDecorator`, `LabelDecorator`
and `NormalizeDecorator` but are reserved for internal use and subject to change.
