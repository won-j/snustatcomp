test_that("rectangular and polar installations support the same selectors", {
  with_empty_operation_table({
    expect_identical(install_rectangular_package(), "done")
    expect_identical(install_polar_package(), "done")
    rect <- Get("make_from_real_imag", "rectangular")(3, 4)
    polar <- Get("make_from_real_imag", "polar")(3, 4)
    expect_identical(type_tag(rect), "rectangular")
    expect_identical(type_tag(polar), "polar")
    for (z in list(rect, polar)) {
      expect_equal(real_part(z), 3)
      expect_equal(imag_part(z), 4)
      expect_equal(magnitude(z), 5)
      expect_equal(angle(z), atan2(4, 3))
    }
    for (representation in c("rectangular", "polar")) {
      z <- Get("make_from_mag_ang", representation)(2, pi / 2)
      expect_equal(real_part(z), 0, tolerance = 1e-12)
      expect_equal(imag_part(z), 2)
      expect_equal(magnitude(z), 2)
      expect_equal(angle(z), pi / 2)
    }
    reset_operation_table()
    expect_error(magnitude(rect), "no method")
    expect_identical(Get("make_from_real_imag", "polar"), FALSE)
  })
})
