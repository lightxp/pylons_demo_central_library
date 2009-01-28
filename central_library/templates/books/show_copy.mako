<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
Item: "${c.copy.item.title}", copy ID ${c.copy.copy_id}
</%def>
<p>${h.link_to("All Items", url("books"))} — ${h.link_to("General view of this item", url("book", id=c.copy.item.item_id))}</p>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>Item ID</td><td>${c.copy.item.item_id}</td></tr>
    <tr><td>Title</td><td>${c.copy.item.title}</td></tr>
    <tr><td>Author</td><td>${c.copy.item.author}</td></tr>
    <tr><td>EAN</td><td>${c.copy.item.ean}</td></tr>
    <tr><td>Publication Date</td><td>${c.copy.item.pub_date}</td></tr>
    <tr><td>Kind</td><td>${c.copy.item.kind}</td></tr>
</table>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>Copy ID</td><td>${c.copy.copy_id}</td></tr>
    <tr><td>Acquired On</td><td>${c.copy.acquired_date}</td></tr>
    <tr><td>Condition</td><td>${c.copy.condition_notes}</td></tr>
</table>

<p>Loans
<table border="0" cellspacing="5" cellpadding="5">
    <tr><th>User's Name</th><th>User's Address</th><th>Checkout Date</th><th>Due Date</th><th>Returned</th></tr>
% for loan in c.copy.loans:
<tr><td>${loan.user.name}</td><td>${loan.user.address}</td><td>${loan.checked_out}</td><td>${loan.due_date}</td><td>${loan.returned}</td></tr>
% endfor
</table>
</p>