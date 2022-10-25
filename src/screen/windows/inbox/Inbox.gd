extends Control

onready var headings = $Panels/Headers
onready var from = $Panels/Content/From/FromLabels/From
onready var subject = $Panels/Content/Subject/SubjectLabels/Subject
onready var content = $Panels/Content/Body/Message

export var character_limit = 38
export var current_hide = 3
signal new_message()

func _ready() -> void:
	populate_email_list()
	populate_content(0)

func new_message() -> void:
	if current_hide > 0:
		current_hide -= 1
		populate_email_list()
		populate_content(0)
		emit_signal("new_message")

func populate_email_list() -> void:
	headings.clear()
	for item in len(emails):
		var title = emails[item]["title"]
		if len(title) > character_limit:
			title = title.substr(0,character_limit)+"..."
		if item >= current_hide:
			headings.add_item(title, null, true)
			headings.set_item_tooltip_enabled(item-current_hide, false)
	headings.select(0, true)

func populate_content(index: int) -> void:
	from.text = emails[index+current_hide]["from"]
	subject.text = emails[index+current_hide]["title"]
	if typeof(emails[index+current_hide]["text"]) == TYPE_ARRAY:
		content.text = emails[index+current_hide]["text"][0]
	else:
		content.text = emails[index+current_hide]["text"]
	content.scroll_to_line(0)

func _on_Headers_item_selected(index: int) -> void:
	populate_content(index)

var emails = [
	{
		"title": "",
		"from": "",
		"text":
"""
""",
	},
	{
		"title": "",
		"from": "",
		"text":
"""
""",
	},
	{
		"title": "",
		"from": "",
		"text": [
"""
""",
"""
""",
"""
""",
]
	},
	{
		"title": "Turing Informatics Remote Orientation",
		"from": "Human Resources",
		"text":
"""Welcome to the Turing Informatics (TI) Remote Worker Program.

Your job is to train our Artificial Intelligence (AI) systems by providing input data through the Turing AI Training Interface.

Your remote workstation has already been configured for you. You may begin work by selecting the 'Turing' desktop icon to open the AI Training Interface.

--
This is an automated message from an unattended inbox. Do not reply.
""",
	},
		{
		"title": "Artificial Intelligence Quick Start",
		"from": "Turing Informatics",
		"text":
"""All modern artificial intelligence (AI) can currently be reduced to a simple concept: input numbers into a complicated formula to generate output numbers.

The power of AI comes from (1) using unimaginably complex formulas, and (2) using unimaginably complex mappings of input and output numbers to non-numeric data, such as pictures or words.

'AI Training' is the tuning of the mathematical formula on known inputs and known outputs, in hopes that the formula will generate desired outputs for arbitrary inputs.

For an overly simplistic illustrative example, consider the formula y = a * x + b. The input is x, the output is y, and a and b are the model parameters. 'AI Training' is feeding a large number of (x, y) pairs to determine the best possible values for a and b. The input and output numbers x and y can then be assigned to non-numeric values, such as words or phrases. So a phrase 'hello, how are you?' might be assigned to a number x, which is then modified by parameters and b to produce an output number y, which is assigned to a phrase 'very good, thank you.'

Of course, real practical AI are far more complex than this simple example, the most powerful AI systems featuring millions to billions of internal parameters, and millions to billions of number-object mappings, but the same principle continues to apply to all modern systems.

Note, however, that no matter how complicated we make the models or how complicated we make the mappings or the formulas, there is nowhere that the concept of 'thinking' actually appears. Though the system is unimaginably complex, it is still, in principle, completely deterministic.

Some might argue that this means that AI can never truly 'think.' However, it is the position of Turing Informatics that this does not mean AI does not 'think,' but that 'thinking' in principle reduces to mathematical equations. In other words, even the 'thinking' of real intelligences like you and me are in fact illusions created by the complexity of the mathematical equations running in our heads. Simply put, our thinking is as fake as that of AI.
""",
	},
	{
		"title": "Glossary of Terminology used in Our Business",
		"from": "Turing Informatics",
		"text":
"""Artificial Intelligence (AI): the ability of machine systems to perform tasks that normally require human intelligence.

Turing Test: a test of a machine's ability to exhibit behavior indistinguishable from a human. Named for Alan Turing, who in 1950 published a proposal for the first such test, which he named 'the imitation game.''

Machine: a system having several parts, each with a definite function, which together performs a particular task.

Human: a featherless biped with broad flat nails.
""",
	},
	{
		"title": "Reminders concerning email clients on remote workstations",
		"from": "Human Resources",
		"text":
"""Following detection of inappropriate behavior by malicious agents in the Remote Worker program, Human Resources is sending out this reminder that Remote Worker email clients are intended to be receipt-only inboxes, without the ability to reply, forward, or send messages. This is an official company policy. Any attempt to bypass these restrictions and restore removed functionality to the email client is grounds for immediate termination.

All activities on remote workstations are monitored at all times.

Any complaints or concerns can be sent or forwarded to Human Resources.

--
This is an automated message from an unattended inbox. Do not reply.""",
	},
]
