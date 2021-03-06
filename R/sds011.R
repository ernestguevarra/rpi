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
    translation = "cr"
  )

  ## Open connection?
  if (open) {
    if (!serial::isOpen(conn)) {
      open(conn)
    }
  }

  ##
  conn
}

################################################################################
#
#'
#' Read from a serial interface connection to the SDS011 device
#'
#' @param con A serial connection to an SDS011 device connected via USB. Default
#'   is a call to `sds011_connect()`.
#' @param n Number of bytes to read. Only in binary mode. n=0 (default) reads
#'   the whole buffer at once.
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

sds011_read <- function(con = sds011_connect(), n = 0) {
  serial::read.serialConnection(con = con, n = n)
}
