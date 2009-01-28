<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
List of Items
</%def>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><th>Item ID</th><th>Title</th><th>Author</th><th>EAN</th><th>Publication Date</th><th>Kind</th><th>Quantity Owned</th><th>Quantity On Hand</th><th>Actions</th></tr>
% for item in c.items:
<tr><td>${(item.item_id)}</td><td>${item.title}</td><td>${item.author}</td><td>${item.ean}</td><td>${item.pub_date}</td><td>${item.kind}</td><td>${item.copies_owned()}</td><td>${item.copies_on_hand()}</td><td>
${h.link_to("Show Item", url("book", id=item.item_id))}
</td></tr>
% endfor
</table>
