// UploadManager
//
// Originally from: http://www.practicalecommerce.com/blogs/post/432-Multiple-Attachments-in-Rails
// This can be implemented better now that we're using jQuery, but for now we just convert
// from a jQuery object to the dom element so it works as before.
function UploadManager(list_target, count, max) {
    this.list_target = list_target;
    this.count = count;
    this.max = (max ? max : -1);

    this.addElement = function(element, record_type) {
        var upload_manager = this;
        if (element[0].nodeName == 'INPUT' && element.attr('type') == 'file') {
            element.attr('name', record_type + '[attachments_attributes][' + upload_manager.count + '][attachment]');
            element.change(function() {
                var new_element = document.createElement('input');
                new_element.type = 'file';
                $(this).before(new_element);
                upload_manager.addElement($(new_element), record_type);
                upload_manager.addListRow($(this));
                $(this).css('position', 'absolute');
                $(this).css('left', '-1000px');
            });
            if (upload_manager.max != -1 && upload_manager.count >= upload_manager.max)
                element.attr('disabled', 'disabled');
            upload_manager.count++;
            upload_manager.current_element = element;
        }
        else
          console.log('Error: not a file input element');
    };
    
    this.addListRow = function(element) {
        var upload_manager = this;
        var new_row = document.createElement('li');
        var new_row_button = document.createElement('a');
        new_row_button.title = 'Remove File';
        new_row_button.href = '#';
        new_row_button.innerHTML = 'Remove';
        new_row_button.onclick = function() {
            $(new_row).remove();
            element.remove();
            upload_manager.count--;
            upload_manager.current_element.removeAttr('disabled');
            return false;
        }
        new_row.innerHTML = element.val().split('/')[element.val().split('/').length - 1];
        new_row.appendChild(new_row_button);
        new_row.element = element;
        upload_manager.list_target.append(new_row);
    };
}
