<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="portalSection" value="${param.portalSection}" />

<c:choose>
    <c:when test="${portalSection eq 'admin'}">
        <jsp:include page="/WEB-INF/layout/tiles/admin/HeaderAdmin.jsp" />
    </c:when>
    <c:when test="${portalSection eq 'recruiter'}">
        <jsp:include page="/WEB-INF/layout/tiles/recruiter/HeaderRecruiter.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/layout/tiles/member/HeaderMember.jsp" />
    </c:otherwise>
</c:choose>