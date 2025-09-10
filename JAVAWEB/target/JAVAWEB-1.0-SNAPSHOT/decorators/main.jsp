<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title><decorator:title default="JAVAWEB"/></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <decorator:head/>
</head>
<body>
<div class="container-fluid min-vh-100 d-flex flex-column p-0">
    <jsp:include page="/common/header.jsp"/>
    <div class="container my-4 flex-fill">
        <div class="row g-4">
            <div class="col-12 col-lg-3">
                <jsp:include page="/common/left.jsp"/>
            </div>
            <div class="col-12 col-lg-9">
                <decorator:body/>
            </div>
        </div>
    </div>
    <jsp:include page="/common/footer.jsp"/>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


