Module = ( Line )+

Line = __ o:( Org / Equ / Label / Comment /
              OpWithParams / OpWithoutParams / Misc ) __ Linebreak? { return o; }

Misc = c:Chars {
  return { type: 'TEXT', data: c };
}

Comment = ";" c:$[^\n]+ {
  return { type: 'COMMENT', data: c };
}

Label = c:LabelChars ":" {
  return { type: 'LABEL', data: c };
}

OpWithoutParams = op:OpChars __ Comment? {
  return { type: 'OP', data: { op: op, params: [] } };
}

OpWithParams = op:OpChars whitespace __ params:( QuotedParam / Param )* __ Comment? {
  return { type: 'OP', data: { op: op, params: params } };
}

OpChars = $[\-\+,a-zA-Z_0-9]+

Param = c:$[^, \n\r\t;]+ __ ","? __ { return c; }

QuotedParam = '"' c:$[^"\n\r]+ '"' __ ","? __ { return c; }

Equ = label:LabelChars __ 'equ'i __ value:$[^ \n\r\t;]+ __ Comment? {
  return { type: 'EQU', data: { label: label, value: value } };
}

Org = 'org'i __ value:$[0-9]+ __ Comment? {
  return { type: 'ORG', data: value }
}

Chars = $[^\n\r]+

LabelChars = $[._0-9a-zA-Z]+

Linebreak = [\r\n]+

__ = whitespace*

whitespace = [ \t]
