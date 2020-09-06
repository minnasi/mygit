<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/css/megabox.min.css" rel="stylesheet">
<link href="/css/main.css" rel="stylesheet">
<link href="/css/custom.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
	<c:import url="/resources/common/header.jsp"></c:import>
	<div class="container">
		<div class="inner-wrap">
			<div id="contents" class="">
				<h2 class="tit">영화 등록</h2>
				<p class="reset mt30 a-r font-orange">* 필수</p>

				<div class="table-wrap mt10">
					<form action="/insertMovie" method="POST">
						<table class="board-form va-m">
							<colgroup>
								<col style="width: 150px;">
								<col>
								<col style="width: 150px;">
								<col>
							</colgroup>
							<tbody>


								<tr>
									<th scope="row"><label for="title">영화 제목</label> <em
										class="font-orange">*</em></th>
									<td colspan="3"><input type="text" name="movieName"
										id="title" class="input-text" maxlength="100"></td>
								</tr>


								<tr>
									<th scope="row"><label for="hpNum1">영화 상영 시간</label> <em
										class="font-orange">*</em></th>
									<td><input type="text" name="movieTime"
										class="input-text width100  numType" maxlength="15"
										title="상영끝시간" placeholder="상영시간을 적어주세용"></td>

								</tr>
								<tr>
									<th scope="row"><label for="textarea">내용</label> <em
										class="font-orange">*</em></th>
									<td colspan="3">

										<div class="textarea">
											<textarea id="textarea" name="movieSynopsis" rows="5" cols="30"
												title="내용입력" placeholder="자세한 내용일수록 좋습니당 후후  최대 2000자"
												class="input-textarea"></textarea>
											<div class="util">
												<p class="count">
													<span id="textareaCnt">0</span> / 2000
												</p>
											</div>
										</div>

									</td>
								</tr>
								<tr>
									<th scope="row"><label for="pw">관리자 아이디</label> <em
										class="font-orange">*</em></th>
									<td colspan="3"><input type="text" id="managerId" name="manager.managerId"
										class="input-text w150px" placeholder="관리자 아이디"></td>
								</tr>

								<tr>

									<th scope="row"><label>이미지 등록 </label></th>

									<td colspan="3">


										<div class="form-group">
											<label>영화 이미지를 등록해주세요</label> 
											<input class="form-control"
												type="file" name="files" multiple>
												<h2 class="selectThumbnail"></h2>
												<input type="hidden" name="moviePoster" value="">
												<input type="hidden" name="moviePosterBG" value="">
										</div>


									</td>
								</tr>

							</tbody>
						</table>
						<div class="btn-group pt40">
							<button type="submit" class="button purple large">등록</button>
						</div>
					</form>
				</div>


				<!-- </form> -->
			</div>
		</div>
		<c:import url="/resources/common/footer.jsp"></c:import>
	</div>
<script src="/js/manager.js"></script>	
</body>
</html>

<%--			<div class="form-group">
								 <button class="btn btn-primary" type="submit">Upload</button>
											</div>--%>
