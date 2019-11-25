#dyn.load('src/mmpca.so')
#library.dynam('mmpca', 'mmpca', 'src')

lambda_len <- 4

#' @useDynLib mmpca r_optim
c_optim_mmpca <- function(theta, X, masks, inds, k, p, lambda, trace,
    num_threads) {
  if (length(lambda) < lambda_len) {
    lambda <- c(lambda, rep(0, lambda_len - length(lambda)))
  }
	.Call('r_optim', theta, X, masks, as.integer(inds - 1), as.integer(k),
    as.integer(p), lambda, trace, as.integer(num_threads), PACKAGE='mmpca')
}

#' @useDynLib mmpca r_obj
c_objective <- function(theta, X, masks, inds, k, p, lambda) {
  if (length(lambda) < lambda_len) {
    lambda <- c(lambda, rep(0, lambda_len - length(lambda)))
  }
	.Call('r_obj', theta, X, masks, as.integer(inds - 1), as.integer(k),
    as.integer(p), lambda, PACKAGE='mmpca')
}

#' @useDynLib mmpca r_grad
c_gradient <- function(theta, X, masks, inds, k, p, lambda, num_threads) {
  if (length(lambda) < lambda_len) {
    lambda <- c(lambda, rep(0, lambda_len - length(lambda)))
  }
	.Call('r_grad', theta, X, masks, as.integer(inds - 1), as.integer(k),
    as.integer(p), lambda, as.integer(num_threads), PACKAGE='mmpca')
}

#' @useDynLib mmpca r_inv_v
c_invVinner <- function(V, Vorth) {
  -t(.Call('r_inv_v', cbind(V, Vorth), PACKAGE='mmpca'))
}

#' @useDynLib mmpca r_init_parallel
c_init_parallel <- function() {
  .Call('r_init_parallel', PACKAGE='mmpca')
}
