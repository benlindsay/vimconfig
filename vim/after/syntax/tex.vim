" Prevent spellcheck highlighting in comments of tex files
syn cluster texCommentGroup contains=@NoSpell

" Prevent underscores and such that aren't in a recognized math region from
" being highlighted in red
syn clear texOnlyMath
