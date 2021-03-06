################################################################################
#
#'
#' Connect to the SDS011 air particulate sensor connected via USB
#'
#' @return A serial interface connection to the SDS011 device via USB
#'
#' @examples
#' \donttest{
#'   sds011_connect()
#' }
#'
#' @export
#'
#
################################################################################

sds011_connect <- function() {
  serial::serialConnection(
    name = "rpi-sds011",
    port = "ttyUSB0",
    mode = "9600,n,8,1"
  )
}

################################################################################
#
#'
#' Read from a serial interface connection to the SDS011 device
#'
#' @return Readings from a serial interface connection to the SDS011 device
#'
#' @examples
#' \dontrun{
#'   sds011_read()
#' }
#'
#' @export
#'
#'
#
################################################################################

sds011_read <- function() {
  conn <- sds011_connect()

  serial::read.serialConnection(con = conn, n = 0)
}
