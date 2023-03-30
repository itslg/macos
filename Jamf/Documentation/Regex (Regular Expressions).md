# Regex Cheat Sheet
## What is regex?[#](https://www.keycdn.com/support/regex-cheat-sheet#what-is-regex)

Regex, also commonly called regular expression, is a combination of characters that **define a particular search pattern**. These expressions can be used for matching a string of text, find and replace operations, data validation, etc. For example, with regex you can easily check a user's input for common misspellings of a particular word.

This guide provides a regex cheat sheet that you can use as a reference when creating regex expressions. We will also go over a couple of popular regex examples and mention a few tools you can use to validate/create your regex expressions.

## Regex cheat sheet[#](https://www.keycdn.com/support/regex-cheat-sheet#regex-cheat-sheet)

Consult the following regex cheat sheet to get a quick overview of what each regex token does within an expression.

| REGEX BASICS | DESCRIPTION                                                                                          |
|--------------|------------------------------------------------------------------------------------------------------|
| ^            | The start of a string                                                                                |
| $            | The end of a string                                                                                  |
| .            | Wildcard which matches any character, except newline (\n).                                           |
| \|           | Matches a specific character or group of characters on either side (e.g. a\|b corresponds to a or b) |
| \            | Used to escape a special character                                                                   |
| a            | The character "a"                                                                                    |
| ab           | The string "ab"   


| QUANTIFIERS | DESCRIPTION                             |
|-------------|-----------------------------------------|
| *           | Used to match 0 or more of the previous |
| ?           | Matches 0 or 1 of the previous          |
| +           | Matches 1 or more of the previous       |
| {5}         | Matches exactly 5                       |
| {5, 10}     | Matches everything between 5-10         |

| CHARACTER CLASSES | DESCRIPTION                        |
|-------------------|------------------------------------|
| \s                | Matches a whitespace character     |
| \S                | Matches a non-whitespace character |
| \w                | Matches a word character           |
| \W                | Matches a non-word character       |
| \d                | Matches one digit                  |
| \D                | Matches one non-digit              |
| [\b]              | A backspace character              |
| \c                | A control character                |

| SPECIAL CHARACTERS | DESCRIPTION                 |
|--------------------|-----------------------------|
| \n                 | Matches a newline           |
| \t                 | Matches a tab               |
| \r                 | Matches a carriage return   |
| \ZZZ               | Matches octal character ZZZ |
| \xZZ               | Matches hex character ZZ    |
| \0                 | A null character            |
| \v                 | A vertical tab              |

| GROUPS  | DESCRIPTION                                       |
|---------|---------------------------------------------------|
| (xyz)   | Grouping of characters                            |
| (?:xyz) | Non-capturing group of characters                 |
| [xyz]   | Matches a range of characters (e.g. x or y or z)  |
| [^xyz]  | Matches a character other than x or y or z        |
| [a-q]   | Matches a character from within a specified range |
| [0-7]   | Matches a digit from within a specified range     |

| STRING REPLACEMENTS | DESCRIPTION                  |
|---------------------|------------------------------|
| $ backtick                  | Insert before matched string |
| $'                  | Insert after matched string  |
| $+                  | Insert last matched          |
| $&                  | Insert entire match          |
| $n                  | Insert nth captured group    |

| ASSERTIONS | DESCRIPTION                                          |
|------------|------------------------------------------------------|
| (?=xyz)    | Positive lookahead                                   |
| (?!xyz)    | Negative lookahead                                   |
| ?!= or ?<! | Negative lookbehind                                  |
| \b         | Word Boundary (usually a position between /w and /W) |
| ?#         | Comment                                              |

#### 1. Matching an email address[#](https://www.keycdn.com/support/regex-cheat-sheet#1-matching-an-email-address)

To match a particular email address with regex we need to utilize various tokens. The following regex snippet will match a commonly formatted email address.

```regex
/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,5})$/
```

The first part of the above regex expression uses an `^` to start the string. Then the expression is broken into three separate groups.

-   **Group 1** `([a-z0-9_\.-]+)` - In this section of the expression, we match one or more lowercase letters between a-z, numbers between 0-9, underscores, periods, and hyphens. The expression is then followed by an `@` sign.
-   **Group 2** `([\da-z\.-]+)` - Next, the domain name must be matched which can use one or more digits, letters between a-z, periods, and hyphens. The domain name is then followed by a period `\.`.
-   **Group 3** `([a-z\.]{2,5})` - Lastly, the third group matches the top level domain. This section looks for any group of letters or dots that are 2-5 characters long. This can also account for region-specific top level domains.

Therefore, with the regex expression above you can match many of the commonly used emails such as `firstname.lastname@domain.com` for example.

#### 2. Matching a phone number[#](https://www.keycdn.com/support/regex-cheat-sheet#2-matching-a-phone-number)

To use regex in order to search for a particular phone number we can use the following expression.

```regex
/^\b\d{3}[-.]?\d{3}[-.]?\d{4}\b$/
```

This expression is somewhat similar to the email example above as it is broken into 3 separate sections. Once again, to start off the expression, we begin with `^.`

-   **Section 1** `\b\d{3}` - This section begins with a word boundary to tell regex to match the alpha-numeric characters. It then matches 3 of any digit between 0-9 followed by either a hyphen, a period, or nothing `[-.]?`.
-   **Section 2** `\d{3}` - The second section is quite similar to the first section, it matches 3 digits between 0-9 followed by another hyphen, period, or nothing `[-.]?`.
-   **Section 3** `\d{4}\b` - Lastly, this section is slightly different in that it matches 4 digits instead of three. The word boundary assertion is also used at the end of the expression. Finally, the end of the string is defined by the `$`.

Therefore, with the above regex expression for finding phone numbers, it would identify a number in the format of 123-123-1234, 123.123.1234, or 1231231234.

Source: https://www.keycdn.com/support/regex-cheat-sheet

---

## Regex Tools
Regex101 - Dynamic Regex Builder
https://regex101.com
## Regex Notes
### Matching Number Combinations (0-999)

https://stackoverflow.com/questions/3071162/regex-to-match-0-999-but-not-blank

This will match (only) a series of one to three numeric digits (including 0 or 00 or 01 or 012 - not clear if those latter ones are desired):

```regex
^\d{1,3}$
```

It will not match empty string (but then neither will your original convoluted expression).

(To allow this as part of a bigger string, remove the `^` and `$` anchors.)  
  

But perhaps regex is not best option here - does whatever base language you're using not have an isNumeric function?  
  

To allow 0 but not other 0-prefixed numbers, you can use:

```regex
0|[1-9]\d{0,2}
```

Or, to ensure that's the entire match:

```regex
^(?:0|[1-9]\d{0,2})$
```


