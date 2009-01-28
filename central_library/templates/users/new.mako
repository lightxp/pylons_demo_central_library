<%inherit file="/layout.mako"/>
<%def name="pagetitle()">
New User
</%def>

${h.link_to("All Users", url("users"))}

${h.form(url('users'))}
<% mt = h.ModelTags(None) %>
<table border="0" cellspacing="5" cellpadding="5">
    <tr><td>Name</td><td>${mt.text('name')}</td></tr>
    <tr><td>Address</td><td>${mt.textarea("address")}</td></tr>
    <tr><td>Is Staff?</td><td>${mt.checkbox('is_staff')}</td></tr>
    <tr><td></td><td>${h.submit("submit", "Create User")}</td></tr>
</table>
</form>