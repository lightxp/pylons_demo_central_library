<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
Item: "${c.item.title}"
</%def>
<p>${h.link_to("All Items", url("books"))}</p>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>Item ID</td><td>${c.item.item_id}</td></tr>
    <tr><td>Title</td><td>${c.item.title}</td></tr>
    <tr><td>Author</td><td>${c.item.author}</td></tr>
    <tr><td>EAN</td><td>${c.item.ean}</td></tr>
    <tr><td>Publication Date</td><td>${c.item.pub_date}</td></tr>
    <tr><td>Kind</td><td>${c.item.kind}</td></tr>
</table>
<p>Copies
<table border="0" cellspacing="5" cellpadding="5">
    <tr><th>Copy ID</th><th>Acquired On</th><th>Condition</th><th>Checked Out?</th><th>Checked Out To</th><th>Due Date</th><th>Actions</th></tr>
% for copy in c.item.copies:
    <tr><td>${copy.copy_id}</td><td>${copy.acquired_date}</td><td>${copy.condition_notes}</td><td>${copy.is_out()}</td><td>${copy.current_loan().user.name if copy.is_out() else u""}</td><td>${copy.current_loan().due_date if copy.is_out() else u""}</td><td>
% if copy.is_out():
${h.form(url('checkin_copy', id=copy.copy_id))}
${h.submit("checkin", "Checkin")}
% else:
${h.form(url('checkout_copy', id=copy.copy_id))}
${h.select("user_id", "", c.users, prompt="Select name...")}
${h.submit("checkout", "Checkout")}
</form>
% endif
</td></tr>
% endfor
</table>
</p>