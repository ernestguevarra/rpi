################################################################################
#
#'
#' Connect to the SDS011 air particulate sensor connected via USB
#'
#' @param open Logical. Should connection be opened once established? Default to
#'   TRUE
#'
#' @return A serial interface connection to the SDS011 device via USB
#'
#' @examples
#' \dontrun{
#'   sds011_connect()
#' }
#'
#' @export
#'
#
################################################################################

sds011_connect <- function(open = TRUE) {
  ## Create connection
  conn <- serial::serialConnection(
    name = "rpi-sds011",
    port = "ttyUSB0",
    mode = "115200,n,8,1",
    buffering = "none",
    newline = 1,
    translation = "auto"
  )

  ## Open connection?
  if (open) {
    if (!serial::isOpen(conn, rw = "read")) {
      open(conn)
    }
  }
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
