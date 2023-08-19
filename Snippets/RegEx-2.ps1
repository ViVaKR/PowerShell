"Hello World" -match "Wor"
"Hello World" -cmatch "hello"
"Hello World" -imatch "world"

"The number 7 is great!" -match "\d"

"Hello World, Welcome" -match "hello\s(\w+), welcome"

'big' -match 'b[iou]g' # true

#! Range
42 -match '[0-9][0-9]' # true

#! Numbers
'Server-01' -match 'Server-\d\d' #- True

#! Word characters
'Book' -match '\w' #- True, first word character 'B'

#! Wildcards
#- any 4 characters except the newline
'a1\ ' -match '....' # True

#! Whitespace
#- Any whitespce : `\s` != `\S`
' - ' -match '\s- ' # True







