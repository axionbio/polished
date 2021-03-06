#' get_app_users
#'
#' @param conn the database connection
#' @param app_name_ the name of the app or `NULL` to get all app users. Defaults to NULL.
#'
#' @return a data frame of the app users from the polished schema.
#'
#' @export
#'
#' @importFrom dplyr tbl filter select collect left_join arrange .data
#' @importFrom dbplyr in_schema
#' @importFrom rlang !! enquo
#'
get_app_users <- function(conn, app_name_ = NULL) {
  hold_app_name <- rlang::enquo(app_name_)

  # find all users of the app
  app_users <- conn %>%
    dplyr::tbl(dbplyr::in_schema("polished", "app_users"))


  if (!is.null(app_name_)) {
    app_users <- app_users %>%
      dplyr::filter(.data$app_name == !!app_name_)
  }

  app_users <- app_users %>%
    dplyr::select(
      app_uid = .data$uid,
      .data$app_name,
      .data$user_uid,
      .data$is_admin,
      .data$created_at) %>%
    dplyr::collect()

  app_user_uids <- app_users$user_uid

  # find the email address for all users of the app
  app_user_emails <- conn %>%
    dplyr::tbl(dbplyr::in_schema("polished", "users")) %>%
    dplyr::filter(.data$uid %in% app_user_uids) %>%
    dplyr::select(user_uid = .data$uid, .data$email) %>%
    dplyr::collect()

  app_users %>%
    dplyr::left_join(app_user_emails, by = "user_uid")
}