# The records mailer manages emailing of records.
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
class RecordsMailer < ActionMailer::Base
  default from: "BobCat e-Shelf <lib-no-reply@nyu.edu>"

  # Sends an email with the selected records
  #   Usage: record_email(user, emailable_records, email_format[, to_address])
  #     email_format is one of :brief | :medium | :full
  def records_email(*args)
    @user = args.shift
    @records = args.shift
    @email_format = args.shift
    @records = emailable_records(@records, @email_format)
    raise ArgumentError.new("Unknown format") unless RecordsController::WHITELISTED_EMAIL_FORMATS.include?(@email_format)
    to_address = (args.shift || @user.email)
    mail(to: to_address, subject: I18n.t('record.collection.email.subject'))
  end

  # Returns a set of emailable records
  def emailable_records(records, email_format)
    @emailable_records ||= records.collect{ |record| emailable_record(record, email_format) }
  end
  helper_method :emailable_records

  # Returns a emailable record
  def emailable_record(record, email_format)
    RecordDecorator.email(record, self, email_format)
  end
  helper_method :emailable_record
end
