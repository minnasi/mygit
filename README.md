<<<<<<< HEAD


 ------- 프로젝트 설명 첨부 --------
SHOW ME THE MOVIE



   
   


                                        -------- Mybatis Foreach Collection에 관해---------


=========================Mybatis=====================

       <insert id="insertTheater">
            INSERT INTO
            movieInfo(movieCode, theaterCode,movieDate,movieStartTime, movieEndTime)
            VALUES 
            <foreach item="item" index="index" collection="theaterName" separator=",">
                 <foreach item="time" index="timeIndex" collection="movieStartTime" separator=",">
                 (
                 (SELECT movieCode FROM movie WHERE movieName = #{movieName}) ,
                 (SELECT theaterCode FROM theater WHERE theaterName = #{item}) ,
                 (SELECT date_format(#{movieDate},'%Y-%m-%d') FROM dual) ,
                  #{time}, '${movieEndTime[timeIndex]}'
                 )
                 </foreach>
            </foreach>
        </insert>
   
================  DAO  ========================
   
   
         public void insertTheater(
                  @Param("movieDate") String movieDate, 
                  @Param("movieName") String movieName, 
                  @Param("theaterName") List<String> theaterName,
                  @Param("movieStartTime") List<String> movieStartTime, 
                  @Param("movieEndTime") List<String> movieEndTime
       );
       
       
   ================================================
 
 
   주목할 부분은 :  #{time}, '${movieEndTime[timeIndex]}' 
   
   컬렉션의 item인 #{time}은 리스트의 해당 순번의 것을 잘 받아옴 (ex.  list.get(i) 느낌)
   
   하지만 foreach 컬렉션 대상이 아닌 ${movieEndTime[timeIndex]}은 parameter로 List로 넘겨줬을뿐인데  #{객체}로 불러와졌음. 
   Foreach내에서도 컬렉션에 있는 대상만 부를수 있는게 아니라 매핑된 key값을 부르면 매핑이 됨. 
   단,  ${} 매핑이기 때문에  ''가 생략되어 붙혀줘야됨. 
   (  #{} 매핑은   preparedstatement처럼 ? 로 들어가서 ''가 들어간것 뿐임  )
   
 
   
   
   
   
   
   
   
   
   
   
   
      ------------------------------------------------- 2020. 04. 09  -------------------------------------------------
                 
                 
             1. 좌석 선택 이벤트처리 + 유효성검사 ( 인원선택 : 2, 좌석 2개 넘게 선택 시 선택 불가)
             2.  예매 좌석 배열로 DB에 저장 
             3.  취소 시 배열로 저장된 좌석 파싱 후 좌석 상태 되돌리기
             4.  Seat Table을 현재 등록된 영화상영정보 갯수만큼 데이터를 넣어줌 (연산)
             5.  필요한 정보만 VIEW에 보여줄 수 있게끔 jsp수정
             6.  VIEW 테이블 만들 수 있게끔 DAO에 주석처리해서 추가
             7.  DB에서 잘못된 정보 검색 안하게 Parameter들 수정 (Booking, MovieInfo , Cancle, Tikkect)

             1.  필요없는 jsp 지움
             2.  INSERT와 UPDATE 와  SELECT가 동시에 이루어 지는 부분은 트랜잭션 처리
   
   
   

   
   
      ------------------------------------------------- 2020. 04. 08  -------------------------------------------------
   
   
   

        학원 -  1. 영화상영정보 등록 :  영화, 여러개의 지역, 여러개의 지역내의 여러개의 상영관,  여러개의 상영관의 여러개의 시간들 등록 
                   위의 마이바티스 설명으로 처리했음
                2. 전체적인 오류 수정... 병합하니까 연쇄적으로 버그 많이생김...
                3. 10~12일 기준으로 시연용 데이터 넣기
                4. 필요한 정보 기준으로 jsp 수정
                5. 전체적인 Process Flow 기준으로 이벤트 처리 확실하게 수정 
                 ( 동적으로 생긴 Elements  이벤트 위임 -> 이벤트 캡쳐링 처리 )
   
   
   
   
         집:   전체적인 process flow  오류 다 고침
         
                             ----------------     영화예매       --------------
                              
                  1 .  영화, 지역, 극장 선택 시 시간별로 등록되어 있는 영화 정보들의 잔여좌석뜨게 함
                  2.   시간별로 등록되어있는 영화 정보들의 좌석 테이블과 JOIN 해서  DB저장  
                         (예매하면 그 시간대의 영화 좌석만 업데이트 됨)
                  3.   예매된 좌석 disabled처리
                  4.   카카오페이를 통해 결제가 완료되면 예매내역에 insert
                  5.   결제완료되면 해당 좌석의 상태값 변경( seatStatus )
                  6.   날짜 관련 value 수정


                            ----------------     마이페이지    ----------------
                             
                  1.  해당 유저의 예매내역만 가져옴
                  2.  해당 유저의 취소내역만 가져옴
                  3.  예매 취소했을 시 예매한 좌석 상태변경 ( 1 -> 0 ) 그래서 다시 좌석 예매할수있음

                           ------------------      영화 상세페이지   ----------------------
                           
                  1.  스틸 컷 갯수 표시
                  2.  더보기 누르면  닫기  로   닫기  누르면 더보기로 텍스트 변환

                            ----------------     기타    ----------------          
                            
                  1. Seat 테이블에 값이 없을 때 값을 insert해주는 로직 만듬 (임시로 bookingController에 insertSeat() )
                  2. 스노우 뷰 테이블 DAO에 주석처리,  사용중인 뷰 테이블 위에 주석처리 ( 메소드화 예정 )
   
   
   
   
         ------------------------------------------------- 2020. 04. 08  -------------------------------------------------
   
   
                                ----------------    상영시간 등록 페이지       --------------
                              
                  1.   영화 등록된 시간을 연산해서 영화 등록이 안되어 있는 시간 계산 완료
                  2.   영화 상영시간이 안되어 있으면 09~25시까지 연산해서 등록가능한 시간 모두 
                  3.   영화 등록 안된 시간을 AJAX로 VIEW에 바인딩
                  
                  
                  
                  
                             =====================  병합내역  ========================           
                             
                             
                  
                                ----------------     인덱스 페이지       --------------
                              
                  1.   시놉시스 미리보기 이벤트 수정
                  2.   관람평 수정
                  
                                ----------------     마이 페이지       --------------
                              
                  1.   로그인 한 유저로만 마이페이지 접속가능 (세션처리)
                  2.   세션에 있는 유저 아이디로만 예매, 취소내역 검색
                                    
                                ----------------     좌석선택 페이지       --------------
                              
                  1.   예매 완료하면 booking (예매) insert 쿼리 작성
                  2.   예매 완료하면 마이페이지에 예매한 영화정보 넘기기
                                    
                                    
         ------------------------------------------------- 2020. 04. 07  -------------------------------------------------
          ※   병합내용 추가
          
   
   
                                ----------------     상영시간 등록 페이지       --------------
                              
                  1.   영화 등록 시간 별 등록할 수 있는 시간 계산
                       ex)  14:00~16:05,     18:30~20:35  상영중이면
                            16:15~18:20이 뜨게 나옴
                       맨 뒤의 상영시간과 25시까지의 빈 시간 있으면 계산해서 List에 넣음
                       ex) 마지막 상영시간 : 18:20~20:00
                       계산 : 2개 등록가능
                       등록가능한 시간 : 20:10~22:15,  22: 30~24:45


                  
                  
                  
                             =====================  병합내역  ========================                  
                  
                  
                  
                                ----------------     회원가입 페이지       --------------
                              
                  1.   아이디, 비밀번호 KeyPress 이벤트 처리 완료
                  2.   회원가입 프로세스 완료 (INSERT 까지)

                  
                                ----------------     로그인 페이지       --------------
                              
                  1.   로그인 프로세스 완료하고 암호화로 로그인 가능하게 짜는중
                                    
                                    
                                ----------------     좌석선택 페이지       --------------
                              
                  1.   JSP에 좌석선택된 것, 안된것 표시
                  2.   JSP에서 ForEach로 좌석개수만큼 좌석 만들기 ( 안되서 js로 표현)
                  
                  
                                ----------------     좌석선택 페이지       --------------
                              
                  1.   마이페이지로 들어가면 예매내역이 뜨게끔 제작 (controller, DAO,Service, JSP)
                  2.   취소내역 기초 제작 (Canclellation Bean, DAO, Controller)
                  
                  



         ------------------------------------------------- 2020. 04. 06  -------------------------------------------------
   
   

                                ----------------     예매 페이지       --------------
                              
                  1.  예매페이지 모두 완성
                       날짜 클릭 시 상영중인 영화만 클릭가능하게, 나머지 영화는 disabled처리
                       영화 클릭 시 영화가 등록된 지역 나오기
                       지역 클릭 시 영화가 등록된 지역의 극장 나오기
                       극장 클릭 시 해당 극장에서 상영중인 영화 정보나오기
                       날짜, 영화 클릭 시 이미 클릭된 지역, 극장 상태변경
                       지역 클릭 시 극장, 상영중인 영화정보 상태변경
                       
                   2.  예매페이지에서 스크린 선택창으로 갈때 해당 영화내용 넘겨서 jsp에 데이터 뜨게하기
  
                  
       ------------------------------------------------- 2020. 04. 05  -------------------------------------------------
                    
                     
                                ----------------    상영시간 등록 페이지       --------------
                              
                  1.   영화등록 시간관련 데이터 바인딩 (GsonBuilder)
                  2.   해당 상영관에 등록된 영화 시간 전부 출력
                  3.   해당 상영관 상영시간에 등록된 시간을 하이라이트, ~회차 표현
                  
                   
                   
       ------------------------------------------------- 2020. 04. 04  -------------------------------------------------
                    
                     
                                ----------------     상영시간 등록 페이지       --------------
                              
                  1.   상영관 번호 배열로 받아와서
                       해당 상영관 상영시간표 리턴해주는 로직 만듬
                       

        ------------------------------------------------- 2020. 04. 03  -------------------------------------------------
                    
                    
                                ----------------     상영시간 등록 페이지       --------------
                              
                  1.   극장누르면 상영관탭에도 누를수 있는 극장이 뜨고 그 극장 누르면 상영관 몇개, 어떤상영관 있는지 뜸
                  2.   상영관 복수선택 가능하고 누르면 누른 상영관만 밑에 뜨게 이벤트 처리
                  3.   상영관마다 등록된 영화시간 뜨게 하는 로직짜는중
                  
                  
                    
        ------------------------------------------------- 2020. 04. 02  -------------------------------------------------
                    
                    
                            
                                ----------------      상영시간 등록 페이지     --------------                  
                  1.   영화등록 -> 영화, 극장, 상영관 선택 이벤트 처리 완료
                       해당 극장 , 상영관 선택 후 컨트롤러에 보내는 ajax작성완료
                  
                  
                                ----------------       기타 ( 로그 )      --------------                           
                  로그 : log4jdbc의 Slf4jSpyLogDelegator 사용
                         기존엔 Mybatis에 <setting name="logImpl" value="LOG4J" /> 만 써서 
                         에러시에만 sqlOnly만 뜸
                            

                    
        ------------------------------------------------- 2020. 04. 01  -------------------------------------------------
        
        
                                    
                                ----------------       좌석선택 페이지     --------------                  
                  1.   결제 요청시 로그인 안되어 있으면 로그인 페이지로 가서 로그인 후 해당 결제페이지로 다시 옴.
                  
                                ----------------       영화상세 페이지     --------------                                    
                  2.   스틸컷, 시놉시스 이벤트 처리,  스틸컷 이미지 사이즈 마다 위치 할당


                    
        ------------------------------------------------- 2020. 03. 31  -------------------------------------------------
        
        
                                    
                                ----------------      예매 페이지     --------------                  
                  1.   예매  DB 구조 변경에 따른 DB로직, 파라미터, 이벤트 변경
                       로그수준 변경 ( Mybatis-config 설정)

                  
                                ----------------       관리자 페이지     --------------    
                                
                     1.  영화선택, 극장선택 클릭이벤트 핸들링
                     2.  극장선택 ajax로 지점 불러오기
                     공통-
                     1. sql.Date 타입 Filter지정
                     2. Mybatis Log레벨 수정
                     3. POJOAspectJ 수정 ( joinpoint Exception 추가)
                     
                     
        ------------------------------------------------- 2020. 03. 30  -------------------------------------------------
                             
                  
                                ----------------     영화 등록 페이지     --------------                  
                  1.   MultipartHttpServletRequest를 사용한 이미지 여러개 등록가능
                  2.   영화등록 전체적인 Process완료
                  3.   체크박스를 통해서 포스터, 백그라운드 이미지 선택가능하게 하기 (미완 : 상영시간등록 끝난후에 처리)
                  
                                ----------------     좌석 선택 페이지     --------------                  
                  1.   screen.jsp 수정 ( 기초가 되는 Class설정 - 좌석선택 가능, 좌석선택 불가, 좌석선택 시 )
                  




        ------------------------------------------------- 2020. 03. 24  -------------------------------------------------
        
                       티켓 (지역, 상영관, 스크린 ) 구현 - 상영관쪽 버그있음.
                       naver, kakao   첫 로그인시 회원가입 자동으로 되게끔 함
                       둘다 로그인하면 session을 user로 user를 줌



        ------------------------------------------------- 2020. 03. 22  -------------------------------------------------
        
                       
                       회의를 통해 DAO에서 어노테이션을 통해 DB접근하지 말고 xml을 통해 하는걸로 결정
                       
                       모든 Bean에 TypeAlias 지정, ResultMap -- movie 지정
                       
                       


        ------------------------------------------------- 2020. 03. 20  -------------------------------------------------
        
                       카카오페이 결제창 구현중
                       자꾸 400BadRequest뜸  - Date타입 받아오는 부분에서 .. 주석처리하고 하니 일단 됨
                       Jackson-DataBind lib받고나니 해결.   이유 찾아보기

                       영화 상세 페이지 JSP 에 데이터바인딩 완료.
                       
                       예매페이지 상영관 클릭시 영화상영시간 뜨게 함 . (09:00~11:20 다크워터스  잔여좌석 100)



        ------------------------------------------------- 2020. 03. 19  -------------------------------------------------
        
                   예매페이지 Ajax로 데이터 받아오는거 완성(append해서 데이터 집어넣는건 아직), event 처리 (on으로 하이라이트 중)
                   영화상세페이지 펼치기,접기 js구현
                   
                   Screen.jsp ( 좌석선택 페이지) 구현
                   템플릿이라..  우리 사이트에 맞게 커스터마이징 완료
                   ( screen.jsp -  component.css ) 

                   


        ------------------------------------------------- 2020. 03. 18 -------------------------------------------------
                  회원가입, 관리자페이지 빼고 프론트 끝
                  (영화페이지, 예매페이지, 로그인페이지, 회원가입페이지, 마이페이지, 헤더, 푸터)
                  
                  Web.xml 필터
                  servlet-context  resources 경로 설정 (js, css, images)
                  magabox, main, custom   CSS 제작
                  
                  --  예매 페이지--
                  더미데이터 넣고 Ajax로 값 받아오는 로직 짬
                  
                  네이버 로그인 작업중
                  scribe받아서 NaverLoginApi, NaverLoginBO, Controller 작성
                  로그인은 되는데 아직 정보를 못뺌 


        ------------------------------------------------- 2020. 03. 17  -------------------------------------------------
                             
                  
                  Show Me the Movie Project 시작..
                  프로젝트 구조 완성
                  Hikari CP 를 사용해서 Mybatis 연동완료
                  Controller, Service, DAO, Domain 패키지 구조 완성
                  메인, 영화상세페이지 제작완료 후 push
=======
# mygit
실습용
vvvvvvv   ujjjhjh
>>>>>>> branch 'master' of https://github.com/minnasi/mygit.git
