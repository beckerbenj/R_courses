# The Markdown Language


## Introduction

This file is formatted using *Markdown*. Mardown is a markup language. It includes texts as well as inline formatting. The formatting rules are limited and simple. This has advantages:

- Raw Markdown files (like this one) are easy to read.
- Markdown formatting can easily be transformed into other formatting languages.
- Markdown formatting can be easily automatically created.

There are also some disadvantages:

- Markdown formatting is limited, you cannot (and should not) do whatever you want.


## Some Formatting Rules


### Headings

Using the # symbol, heading of different levels can be created. More #s implies a lower level. 


### Paragraphs

A new paragraph starts when a blank line is inserted. 
This implies that a new line
does 
not lead
to a 
new paragraph. 


### Text Formatting

You can write text...

- in *bold*, also _like this_. 
- in **italics**, also __like this__
- in ~~strike through~~ 
- in `verbatim code` or `typewriter` (use dubble back-tics ``when ` is included in the code``)
- that is [highlighted]{.mark}
- in ^Superscript^
- in ~subscript~
- in math mode $5^5 - \frac{2}{7}$


Note that when * or _ are surrounded by spaces, they do not lead to changed text formatting_*.


### Lists

#### Unordered lists

- unordered lists can be:
  + made using different symbols (-, +, *)
  + nested
- the indentation plays a role. 
- the type of bullets is chosen automatically


You can also choose to leave more space between the bullets

* like this

* by adding blank lines


#### Ordered lists

1. ordered lists can be:
    a. made using different symbols (1., II., A), (A), a.)
	a. nested
1. the actual used numbers don't matter


### Footnotes

Footnotes can be added inline.^[This makes is easy read and edit, because you do not need to scroll down.]


### Tables

With basic formatting, a table can be created. Columns can be left or right aligned, or centered. 

Left     Right    Center     Default = left
------ -------  ----------   --------------
  some    other         47        .55
values   value     55           .14
here      here        3             .07
------ -------  ----------   --------------

Table:  Simple table syntax. The column headers may be omitted.


### Horizontal Line

You can create a horizontal line with three or more "*", "-" or "_" on one line.

Like this:

* * * * 

or this:

____


### Blocks of Text

#### Block Quotes

> Block quotes are 
easy to make.
>
> They can contain other block quotes
>   
>   > like this
>
> and can contain lists
>
>   1. like
>   1. this


#### Code Block

Using multiple back ticks, a block of "code" is created

```
ab <- a + b
if(ab > 1){print("Too Big!")}
else if(ab < -1){print("Too Small!")}
x <- 1:1000
y <- x^ab
```


### Links

Links are created by including an url in <  and >: For instance <https://google.com>. Alternatively, links can be created [like this](https://google.com). The link text can be formatted, and links to [*e-mail addresses*](mailto:dries.debeer@ugent.be "Mail me!") also work. 


### Figures

A link preceded by a "!" is treated as an image. You can use a locale figure, or use a path to a figure online. 

![Jungle Skills](https://st2.depositphotos.com/2927537/7025/i/600/depositphotos_70253417-stock-photo-funny-monkey-with-a-red.jpg){width=50%}





## More Formatting Rules

A more extensive overview of markdown formatting can be found [here](https://pandoc.org/MANUAL.html#pandocs-markdown/ "Pandoc's Markdown"). There are various definitions of Markdown. RMarkdown uses *pandoc's Markdown*, but for instance github has slightly different formatting rules. The basics, however, typically do not differ between the different definitions.


## Conclusions

Markdown is a simple formatting language. It simplicity makes the raw code easy to read, but limits the formatting freedom. The formatting rules described in this document are not exhaustive. But if you find yourself looking for more specialised formatting rules, Markdown may not the formatting language you are looking for.


