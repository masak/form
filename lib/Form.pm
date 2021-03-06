module Form;

#enum Justify <left right centre full>;
#enum SignType <pre post paren>;
#enum Alignment <top middle bottom>;

grammar Format {
	regex TOP {
		^ '{' <field> '}' $
	}

	regex field {
		<bottom_aligned_field> | <centre_aligned_field> | <aligned_field>
	}

	regex bottom_aligned_field {
		_ <aligned_field> _
	}

	regex centre_aligned_field {
		'=' <aligned_field> '='
	}

	regex aligned_field {
		<left_justified_field> | <centred_field> | <right_justified_field> | <fully_justified_field>
	}

	regex left_justified_field {
		<left_justified_block_field> | <left_justified_line_field>
	}

	regex left_justified_block_field {
		'['+
	}

	regex left_justified_line_field {
		'<'+
	}

	regex centred_field {
		<centred_block_field> | <centred_line_field>
	}

	regex centred_block_field {
		']'+ '['+
	}

	regex centred_line_field {
		'>'+ '<'+
	}

	regex right_justified_field {
		<right_justified_block_field> | <right_justified_line_field>
	}

	regex right_justified_block_field {
		']'+
	}
	
	regex right_justified_line_field {
		'>'+
	}

	regex fully_justified_field {
		<justified_block_field> | <justified_line_field>
	}

	regex justified_block_field {
		'['+ ']'+
	}

	regex justified_line_field {
		'<'+ '>'+
	}
}

class Picture {
	# @.elements is Str|Field when Rakudo supports that
	has @.elements;
}

class Literal {
	has Str $.content;
}

role Field {
	has Bool $.block;
	has Int $.width;
	has $.alignment;
	has $.data;
}

# RAKUDO: Don't know what's correct here, but until [perl #63510] is resolved,
#         we need to write "Form::Field", not "Field".
class TextField does Form::Field {
	has $.justify;
}

# RAKUDO: Don't know what's correct here, but until [perl #63510] is resolved,
#         we need to write "Form::Field", not "Field".
class VerbatimField does Form::Field {
}



sub form(*@args) returns Str is export {
	my @lines;

	return '';
}

# vim: ft=perl6 sw=4 ts=4 noexpandtab

