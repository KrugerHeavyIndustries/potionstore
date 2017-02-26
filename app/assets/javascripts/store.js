function setup_help_values() {
	for (element_id in HELP_VALUES) {
		setup_help_value(element_id);
	}
}

function setup_help_value(element_id) {
	var element = $(element_id).get(0);
	var help_text = HELP_VALUES[element_id];
	if (element.value == help_text) {
		element.value = '';
		element.style.color = '#000';
	}
	else if (element.value == '') {
		element.style.color = '#aaa';
		element.value = help_text;
	}
}
