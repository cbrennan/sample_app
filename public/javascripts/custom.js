Event.observe('micropost_content', 'keyup', textChanged);
Event.observe('micropost_content', 'keydown', textChanged);
function textChanged() {
    var maxLen = 140;
    var left = maxLen - this.getValue().length;
    $('char-count').update(left);
}

