# Changelog

## Unreleased

- **Fixed:**
  - The bank database was re-saved as UTF-8 in April 2025, which replaced all 8022
    non-ASCII characters with U+FFFD. Because the records are fixed width, the three
    extra bytes of every replacement shifted the fields behind it: 1114 of the 4893
    banks with a BIC returned the wrong BIC and a mangled name, and looking them up
    by BIC raised BankNotFoundError. The file is restored to ISO-8859-1 - byte for
    byte the same data, with the Revolut record the same commit added - and the
    three specs that had been failing since then pass again.
  - `BankDb` read the database with `File.open` without a block, leaking the file
    descriptor until the object was collected.

- **Changed:**
  - The gem is developed and tested with Ruby 4.0.6, `required_ruby_version` is `>= 3.2`.
  - Updated the dependencies: `equalizer ~> 0.0.11` stays (1.0.0 cannot be combined with adamantium, see the
    README), `adamantium >= 0.2`, and the development dependencies are current
    (bundler 2.4+, rake 13, rspec 3.13) plus rubocop and simplecov.
  - `Ibanizator#calculate_iban` pads the account number with a single `rjust` instead of
    a loop that could only ever run once.

- **Added:**
  - SimpleCov measures the suite and fails it when line or branch coverage of `lib/`
    drops below 100%. CI comments both percentages on every pull request and runs
    RuboCop.
  - Dependabot keeps the gems and the actions of the workflows up to date.

- **Removed:**
  - `lib/errors/bank_not_found_error.rb` and `lib/errors/invalid_bank_code_error.rb`.
    Nothing required them, they duplicated `Ibanizator::BankDb::BankNotFoundError`, and
    both subclassed `Exception` rather than `StandardError`, so a plain `rescue` would
    not have caught them anyway.

## 0.4.15

- **Features:**
  - Updated bank database (valid until March 04 2023)

## 0.4.14

- **Features:**
  - Updated bank database (valid until December 04 2022)

## 0.4.13

- **Features:**
  - Added 3.1 to tested ruby versions
  - Updated bank database (valid until September 04 2022)

## 0.4.12

- **Features:**
  - Updated bank database (valid until December 05 2021)

## 0.4.11

- **Features:**
  - Updated bank database (valid until September 07 2021)

## 0.4.10

- **Features:**
  - Updated blz.txt (valid until 06.06.2021)
  - Added 3.0.0 to tested ruby versions
  - Added jruby, truffleruby and truffleruby-head to tested ruby versions
  - Changed gem to be tested via github actions instead of travis.ci

## 0.4.9

- **Features:**
  - Updated blz.txt (valid until 07.03.2021)
  - Update tested ruby versions to 2.7.2

## 0.4.8

- **Features:**
  - Updated blz.txt (valid until 06.12.2020)

## 0.4.7

- **Features:**
  - Updated blz.txt (valid until 06.09.2020)
  - Add ruby version 2.7.1 to tests
  - Update tested ruby versions to 2.5.8 and 2.6.6
  - Removed support for ruby 2.4 due to eol since 31.03.2020
  - Updated dev dependencies
  - Updated and added multiple iban lengths ([#27](https://github.com/softwareinmotion/ibanizator/pull/27), [#28](https://github.com/softwareinmotion/ibanizator/pull/28)) ~ *thanks to [skorth](https://github.com/skorth) and [svoop](https://github.com/svoop)*

## 0.4.6

- **Features:**
  - Updated blz.txt (valid until 08.03.2020)
  - Update tested ruby versions to 2.4.9, 2.5.7 and 2.6.5

## 0.4.5

- **Features:**
  - Updated blz.txt (valid until 08.12.2019)
  - Update tested ruby versions to 2.4.7, 2.5.6 and 2.6.4

## 0.4.4

- **Features:**
  - Updated blz.txt (valid until 08.09.2019)
  - Update tested ruby versions to 2.4.6, 2.5.5 and 2.6.3
  - Removed support for ruby 2.3 due to eol since 31.03.2019
  - Removed support for ruby 2.2 due to eol since 31.03.2018

## 0.4.3

- **Features:**
  - Updated blz.txt (valid until 02.06.2019)
  - Updated ruby version from 2.5.3 to 2.6.0

## 0.4.2

- **Features:**
  - Updated blz.txt (valid until 03.03.2019)
  - Updated ruby version from 2.5.1 to 2.5.3
  - Updated Bundesbank link

## 0.4.1

- **Features:**
  - Updated blz.txt (valid until 02.12.2018)

## 0.4.0

- **Breaking Changes:**
  - Removed deprecated class `SwiftBic::BankDb` in favor of `Ibanizator::BankDb` ([#24](https://github.com/softwareinmotion/ibanizator/pull/24))
  - Removed deprecated method `Iban::Validator.validate_iban` in favor of `Ibanizator.iban_from_string(iban).valid?` ([#24](https://github.com/softwareinmotion/ibanizator/pull/24))
  - Removed deprecated method `Ibanizator.new.validate_iban(iban)` in favor of `Ibanizator.iban_from_string(iban).valid?` ([#24](https://github.com/softwareinmotion/ibanizator/pull/24))
  - Removed deprecated method `Ibanizator.new.bic(bank_code)` in favor of `Ibanizator::BankDb.new.bank_by_bank_code(bank_code).bic` ([#24](https://github.com/softwareinmotion/ibanizator/pull/24))
  - Removed deprecated method `Ibanizator.new.bank_name(bank_code)` in favor of `Ibanizator::BankDb.new.bank_by_bank_code(bank_code).name` ([#24](https://github.com/softwareinmotion/ibanizator/pull/24))

- **Features:**
  - Added `formatted_iban_string` instance method to `Ibanizator::Iban` for an iban with spaces. ([#17](https://github.com/softwareinmotion/ibanizator/pull/17)) ~ *thanks to [phoet](https://github.com/phoet)*
  - Also adding a `bank_name` and `to_hash` instance method to `Ibanizator::Iban::ExtendedData::DE`. ([#17](https://github.com/softwareinmotion/ibanizator/pull/17)) ~ *thanks to [phoet](https://github.com/phoet)*
  - Added short version of bics containing an optional branch code e.g. Deutsche Bank can be found either with DEUTDEBBXXX or DEUTDEBB. Additionally changed `#bank_by_bank_code` to favor banks whose bic ends in 'XXX' ([#22](https://github.com/softwareinmotion/ibanizator/pull/22))
  - Removed support for ruby 2.1 and added support for ruby 2.4 and 2.5 ([#23](https://github.com/softwareinmotion/ibanizator/pull/23))
  - Changed the contact information ([#25](https://github.com/softwareinmotion/ibanizator/pull/25))

## 0.3.5

- **Features:**
  - Updated blz.txt (valid until 02.09.2018)

- **Fixes:**
  - Fixed failing test suite ([#20](https://github.com/softwareinmotion/ibanizator/pull/20))

## 0.3.4 and blow

~ *Here be dragons* ~
