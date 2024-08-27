<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    let msg = '${msg}'.trim();
    if (msg) {
        alert(msg);
    }
    location.back();
</script>