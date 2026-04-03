<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<tiles:importAttribute />

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title><c:out value="${title}" /></title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/files/css/base/layout.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/files/css/common/ui.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/files/css/portal/portal-default.css" />
    </head>
    <body class="portal-section-${portalSection}">
        <div id="page-wrapper">

            <jsp:include page="/WEB-INF/jsp/components/layout/Header.jsp">
                <jsp:param name="portalSection" value="${portalSection}" />
            </jsp:include>

            <div id="page-content">
                <tiles:insertAttribute name="body" />
            </div>

            <jsp:include page="/WEB-INF/jsp/components/layout/Footer.jsp">
                <jsp:param name="portalSection" value="${portalSection}" />
            </jsp:include>

        </div>
    </body>
</html>