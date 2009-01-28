<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
Edit User "${c.user.name}"
</%def>

${h.link_to("All Users", url("users"))} — ${h.link_to("Show This User", url("user", id=c.user.user_id))}

${h.form(url('user', id=c.user.user_id), method='put')}
<% mt = h.ModelTags(c.user) %>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>User ID</td><td>${c.user.user_id}</td></tr>
    <tr><td>Name</td><td>${mt.text('name')}</td></tr>
    <tr><td>Address</td><td>${mt.textarea("address")}</td></tr>
    <tr><td>Is Staff?</td><td>${mt.checkbox('is_staff')}</td></tr>
    <tr><td></td><td>${h.submit("submit", "Save Changes")}</td></tr>
</table>
</form>