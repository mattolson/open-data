
//****************************************************************************************
//  Misc Helper Functions
//****************************************************************************************
var Helpers = {
	// Adds the given code to the end of the given function
	addCodeToFunction: function(func, code){
		if (typeof(func) == 'undefined')
			return code;
		else
			return function() { func(); code(); }
	},

	// Adds the given code block to a global function that gets attached to the
	// dom:loaded event just once in layout.
    onDomReady: function() {},
	addToDomReady: function(fn)
	{
		Helpers.onDomReady = Helpers.addCodeToFunction(Helpers.onDomReady, fn);
	},

	focusOnLoad: function(element_name)
	{
		Helpers.addToDomReady(function() { $(element_name).select(); $(element_name).focus(); });
	},

	// Open popup for textile reference
	openTextileReference: function() {
		window.open(
			"http://hobix.com/textile/quick.html",
			"redRef",
			"height=600,width=550,channelmode=0,dependent=0," +
			"directories=0,fullscreen=0,location=0,menubar=0," +
			"resizable=0,scrollbars=1,status=1,toolbar=0"
		);
	}
};

// Multiple File Upload
//    from: http://www.practicalecommerce.com/blogs/post/432-Multiple-Attachments-in-Rails
function MultiSelector(list_target, count, max) {
    this.list_target = list_target;
    this.count = count;
    this.max = (max ? max : -1);

    this.addElement = function(element, record_type) {
        if (element.tagName == 'INPUT' && element.type == 'file') {
            element.name = record_type + '[attachments_attributes][' + this.count + '][attachment]';
            element.multi_selector = this;
            element.onchange = function() {
                var new_element = document.createElement('input');
                new_element.type = 'file';
                this.parentNode.insertBefore(new_element, this);
                this.multi_selector.addElement(new_element, record_type);
                this.multi_selector.addListRow(this);
                this.style.position = 'absolute';
                this.style.left = '-1000px';
            }
            if (this.max != -1 && this.count >= this.max)
                element.disabled = true;
            this.count++;
            this.current_element = element;
        }
        else
          console.log('Error: not a file input element');
    };
    
    this.addListRow = function(element) {
        var new_row = document.createElement('li');
        var new_row_button = document.createElement('a');
        new_row_button.title = 'Remove File';
        new_row_button.href = '#';
        new_row_button.innerHTML = 'Remove';
        new_row.element = element;
        new_row_button.onclick = function() {
            this.parentNode.element.parentNode.removeChild(this.parentNode.element);
            this.parentNode.parentNode.removeChild(this.parentNode);
            this.parentNode.element.multi_selector.count--;
            this.parentNode.element.multi_selector.current_element.disabled = false;
            return false;
        }
        new_row.innerHTML = element.value.split('/')[element.value.split('/').length - 1];
        new_row.appendChild(new_row_button);
        this.list_target.appendChild(new_row);
    };
}
