<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
Show User "${c.user.name}"
</%def>
${h.link_to("All Users", url("users"))} — ${h.link_to("Edit This User", url("edit_user", id=c.user.user_id))}

<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>User ID</td><td>${c.user.user_id}</td></tr>
    <tr><td>Name</td><td>${c.user.name}</td></tr>
    <tr><td>Address</td><td>${c.user.address}</td></tr>
    <tr><td>Is Staff?</td><td>${c.user.is_staff}</td></tr>
</table>
