<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>HOME</title>
  <!-- Favicons -->
  <link href="/topaz//topaz/assets/img/TOPAZ_logo.png" rel="icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="/topaz/assets/vendorGST/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/aos/aos.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/swiper/swiper-bundle.min.css" rel="stylesheet">
  <link href="/topaz/assets/vendorGST/glightbox/css/glightbox.min.css" rel="stylesheet">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- Jquery -->

  <!-- Main CSS File -->
  <link href="/topaz/assets/css/main.css" rel="stylesheet">
</head>

<body class="index-page">
  <!-- Header -->
  <header id="header" class="header d-flex align-items-center sticky-top">
    <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">

      <a href="gstMain" class="logo d-flex align-items-center">
        <!-- 로고 이미지 -->
        <img src="/topaz/assets/img/TOPAZ_logo.png" alt="">
        <h1 class="sitename">TOPAZ.</h1>
      </a>

      <nav id="navmenu" class="navmenu">
        <ul>
          <li><a href="gstMain" class="active">Home</a></li>
          <li><a href="infoPrograms">서비스 및 프로그램</a></li>
          <li class="dropdown"><a href="infoRegident"><span>시설 안내</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
            <ul>
              <li><a href="infoRegidentDiamond">다이아몬드동</a></li>
              <li><a href="infoRegidentSilver">실버동</a></li>
              <li><a href="infoStep">입주 절차</a></li>
            </ul>
          </li>
          <li><a href="volunteerRqAdd">봉사 신청</a></li>
          <li><a href="newsList">알림마당</a></li>
         <!-- JavaScript로 동적으로 변경될 부분 -->
          <li><a href="gstMyInfo" id="gstMyInfo" class="active">내 정보</a></li>
          <li><a href="gstLogin" id="gstLogin" class="active">로그인</a></li>
          <li><a href="signUp" id="signUp" class="active">회원가입</a></li>
          <li><a href="${pageContext.request.contextPath}/gstLogout" id="logout">로그아웃</a></li>
        </ul>
        <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
      </nav>
    </div>
  </header><!-- Header 끝 -->

  <main class="main">

    <!-- Section 1 -->
    <section id="about" class="about section">

      <div class="container">
        <div class="row align-items-center justify-content-between">
          <div class="col-lg-7 mb-5 mb-lg-0 order-lg-2" data-aos="fade-up" data-aos-delay="400">
            <div class="swiper init-swiper">
              <script type="application/json" class="swiper-config">
                {
                  "loop": true,
                  "speed": 600,
                  "autoplay": {
                    "delay": 5000
                  },
                  "slidesPerView": "auto",
                  "pagination": {
                    "el": ".swiper-pagination",
                    "type": "bullets",
                    "clickable": true
                  },
                  "breakpoints": {
                    "320": {
                      "slidesPerView": 1,
                      "spaceBetween": 40
                    },
                    "1200": {
                      "slidesPerView": 1,
                      "spaceBetween": 1
                    }
                  }
                }
              </script>
              <div class="swiper-wrapper">
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/img_h_6.jpg" alt="Image" class="img-fluid">
                </div>
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/img_h_7.jpg" alt="Image" class="img-fluid">
                </div>
                <div class="swiper-slide">
                  <img src="/topaz/assets/img/img_h_8.jpg" alt="Image" class="img-fluid">
                </div>
              </div>
              <div class="swiper-pagination"></div>
            </div>
          </div>
          <div class="col-lg-4 order-lg-1">
            <span class="section-subtitle" data-aos="fade-up"></span>
            <h1 class="mb-4" data-aos="fade-up">
              TOPAZ
            </h1>
            <p data-aos="fade-up">
            	TOPAZ는 건강하고 행복한 삶을 추구하는 혁신적인 커뮤니티입니다. 우리는 최첨단 시설과 다양한 프로그램을 통해 고객에게 최고의 경험을 제공합니다.
            </p>
            <p>
              우리의 목표는 모든 세대가 즐길 수 있는 커뮤니티를 만드는 것이며, 이를 위해 꾸준히 노력하고 있습니다.
            </p>
          </div>
        </div>
      </div>
    </section><!-- Section 1 끝 -->

    <!-- Section 2 -->
    <section id="about-2" class="about-2 section light-background">

      <div class="container">
        <div class="content">
          <div class="row justify-content-center">
            <div class="col-sm-12 col-md-5 col-lg-4 col-xl-4 order-lg-2 offset-xl-1 mb-4">
              <div class="img-wrap text-center text-md-left" data-aos="fade-up" data-aos-delay="100">
                <div class="img">
                  <img src="/topaz/assets/img/img_v_3.jpg" alt="circle image" class="img-fluid">
                </div>
              </div>
            </div>

            <div class="offset-md-0 offset-lg-1 col-sm-12 col-md-5 col-lg-5 col-xl-4" data-aos="fade-up">
              <div class="px-3">
                <h2 class="content-title text-start"></h2>
                <p class="lead">
                  TOPAZ는 고객 만족을 최우선으로 하며, 친환경적이고 지속 가능한 방법으로 사업을 운영합니다. 또한, 직원의 행복과 성장을 중요하게 여기며, 모든 이해관계자와의 신뢰를 바탕으로 하는 경영 방침을 고수합니다.
                </p>
                <p class="mb-5">
                  <ul>
                  <li>고객 만족 최우선</li>
                  <li>친환경 경영</li>
                  <li>직원 성장과 행복</li>
                  <li>지속 가능한 발전</li>
                </ul>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Section 2 -->
   
    
    <!-- Slide Section -->
    <section id="testimonials" class="testimonials section">
      <!-- Section Title -->
      <div class="container section-title" data-aos="fade-up">
        <p>Happy Customers</p>
        <h2>Testimonials</h2>
      </div><!-- End Section Title -->

      <div class="container" data-aos="fade-up">
        <div class="row justify-content-center">
          <div class="col-lg-7">
            <div class="swiper init-swiper">
              <script type="application/json" class="swiper-config">
                {
                  "loop": true,
                  "speed": 600,
                  "autoplay": {
                    "delay": 5000
                  },
                  "slidesPerView": "auto",
                  "pagination": {
                    "el": ".swiper-pagination",
                    "type": "bullets",
                    "clickable": true
                  },
                  "breakpoints": {
                    "320": {
                      "slidesPerView": 1,
                      "spaceBetween": 40
                    },
                    "1200": {
                      "slidesPerView": 1,
                      "spaceBetween": 1
                    }
                  }
                }
              </script>
              <div class="swiper-wrapper">
                <div class="swiper-slide">
                  <div class="testimonial mx-auto">
                    <figure class="img-wrap">
                      <img src="/topaz/assets/img/testimonials/testimonials-1.jpg" alt="Image" class="img-fluid">
                    </figure>
                    <h3 class="name">Adam Aderson</h3>
                    <blockquote>
                      <p>
                        “There live the blind texts. Separated they live in
                        Bookmarksgrove right at the coast of the Semantics, a large
                        language ocean.”
                      </p>
                    </blockquote>
                  </div>
                </div>
                <div class="swiper-slide">
                  <div class="testimonial mx-auto">
                    <figure class="img-wrap">
                      <img src="/topaz/assets/img/testimonials/testimonials-2.jpg" alt="Image" class="img-fluid">
                    </figure>
                    <h3 class="name">Lukas Devlin</h3>
                    <blockquote>
                      <p>
                        “There live the blind texts. Separated they live in
                        Bookmarksgrove right at the coast of the Semantics, a large
                        language ocean.”
                      </p>
                    </blockquote>
                  </div>
                </div>
                <div class="swiper-slide">
                  <div class="testimonial mx-auto">
                    <figure class="img-wrap">
                      <img src="/topaz/assets/img/testimonials/testimonials-3.jpg" alt="Image" class="img-fluid">
                    </figure>
                    <h3 class="name">Kayla Bryant</h3>
                    <blockquote>
                      <p>
                        “There live the blind texts. Separated they live in
                        Bookmarksgrove right at the coast of the Semantics, a large
                        language ocean.”
                      </p>
                    </blockquote>
                  </div>
                </div>
              </div>
              <div class="swiper-pagination"></div>
            </div>
          </div>
        </div>
      </div>
    </section><!-- Slide Section 끝 -->

  </main>

  <!-- footer -->
  <jsp:include page="inc/footer.jsp"></jsp:include>
  <!-- Scroll Top -->

  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="/topaz/assets/vendorGST/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/aos/aos.js"></script>
  <script src="/topaz/assets/vendorGST/swiper/swiper-bundle.min.js"></script>
  <script src="/topaz/assets/vendorGST/purecounter/purecounter_vanilla.js"></script>
  <script src="/topaz/assets/vendorGST/glightbox/js/glightbox.min.js"></script>
  <script src="/topaz/assets/vendorGST/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="/topaz/assets/vendorGST/isotope-layout/isotope.pkgd.min.js"></script>

  <!-- Main JS File -->
  <script src="/topaz/assets/js/mainGST.js"></script>
  
</body>

</html>