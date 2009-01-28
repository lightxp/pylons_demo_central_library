<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
List of Users
</%def>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><th>User ID</th><th>Name</th><th>Address</th><th>Is Staff?</th><th>Actions</th></tr>
% for user in c.users:
<tr><td>${(user.user_id)}</td><td>${user.name}</td><td>${user.address}</td><td>${user.is_staff}</td><td>
${h.link_to("Edit", url('edit_user', id=user.user_id))} —
${h.link_to("Show", url('user', id=user.user_id))} —
${h.button_to("Delete", url('user', id=user.user_id), method='DELETE')}
</td></tr>
% endfor
</table>

${h.link_to("New", url('new_user'))}