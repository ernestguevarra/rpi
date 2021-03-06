################################################################################
#
#'
#' Connect to the SDS011 air particulate sensor connected via USB
#'
#' @param port Part name. This is usually operating software dependent. For
#'   Raspberry Pi with an SDS011 device plugged via USB, this will be *ttyUSB0*.
#' @param mode A string concatenating the baud rate, parity, databits and
#'   stopbits of the communication mode separated by a comma. Default to
#'   *"115200,n,8,1"*.
#' @param buffering Connection buffering. Default to *"none"*. Other options
#'   is *"line"* to send buffer after new line character or *"full"* where
#'   write operations are buffed until a connection is flushed.
#' @param newline Logical. Should a transmission end with a newline or not.
#'   Default is TRUE or 1.
#' @param translation End of line character to use. Could be *"lf"*, *"cr"*,
#'   *"crlf"*, *"binary"*, or *"auto"*. Default to *"auto"*.
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

sds011_connect <- function(port = "ttyUSB0", mode = "115200,n,8,1",
                           buffering = "none", newline = TRUE,
                           translation = "auto", open = TRUE) {
  ## Create connection
  conn <- serial::serialConnection(
    name = "rpi-sds011",
    port = port,
    mode = mode,
    buffering = buffering,
    newline = newline,
    translation = translation
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
#' @param interval Reading interval in seconds. Default to 5 seconds.
#'
#' @return Readings from a serial interface connection to the SDS011 device
#'
#' @examples
#' \dontrun{
#'   sds011_read()
#' }
#'
#' @rdname sds011_read
#' @export
#'
#'
#
################################################################################

sds011_read <- function(con = sds011_connect(), n = 0) {
  serial::read.serialConnection(con = con, n = n)
}


################################################################################
#
#'
#' @examples
#' \dontrun{
#'   sds011_read_int()
#' }
#'
#' @rdname sds011_read
#' @export
#'
#
################################################################################

sds011_read_int <- function(con = sds011_connect(), n = 0, interval = 5) {
  while (TRUE) {
    print(list(Sys.time(), sds011_read(con = con, n = 0)))
    Sys.sleep(time = interval)
  }
}
