lbfgsb3_ <-
  function (prm, fn, gr = NULL, lower = -Inf, upper = Inf, control = list(),
            ...)
  {
    tasklist <-
      c(
        "NEW_X", "START", "STOP", "FG", "ABNORMAL_TERMINATION_IN_LNSRCH",
        "CONVERGENCE", "CONVERGENCE: NORM_OF_PROJECTED_GRADIENT_<=_PGTOL",
        "CONVERGENCE: REL_REDUCTION_OF_F_<=_FACTR*EPSMCH", "ERROR: FTOL .LT. ZERO",
        "ERROR: GTOL .LT. ZERO", "ERROR: INITIAL G .GE. ZERO",
        "ERROR: INVALID NBD", "ERROR: N .LE. 0", "ERROR: NO FEASIBLE SOLUTION",
        "ERROR: STP .GT. STPMAX", "ERROR: STP .LT. STPMIN",
        "ERROR: STPMAX .LT. STPMIN", "ERROR: STPMIN .LT. ZERO",
        "ERROR: XTOL .LT. ZERO", "FG_LNSRCH", "FG_START", "RESTART_FROM_LNSRCH",
        "WARNING: ROUNDING ERRORS PREVENT PROGRESS", "WARNING: STP .eq. STPMAX",
        "WARNING: STP .eq. STPMIN", "WARNING: XTOL TEST SATISFIED"
      )
    ctrl <- list(maxit = 100, trace = 0, iprint = 0L)
    namc <- names(control)
    if (!all(namc %in% names(ctrl)))
      stop("unknown names in control: ", namc[!(namc %in%
                                                  names(ctrl))])
    ctrl[namc] <- control
    iprint <- as.integer(ctrl$iprint)
    factr <- 1e+07
    pgtol <- 1e-05
    nmax <- 26260
    mmax <- 17L
    if (length(prm) > nmax)
      stop("The number of parameters cannot exceed 1024")
    n <- as.integer(length(prm))
    m <- 5L
    nbd <- rep(2L, n)
    nwa <- 2 * mmax * nmax + 5 * nmax + 11 * mmax * mmax + 8 *
      mmax
    wa <- rep(0, nwa)
    dsave <- rep(0, 29)
    lsave <- rep(TRUE, 4)
    isave <- rep(0L, 44)
    iwa <- rep(0L, 3 * nmax)
    csave <- ""
    if (length(lower) == 1)
      lower <- rep(lower, n)
    if (length(upper) == 1)
      upper <- rep(upper, n)
    bigval <- .Machine$double.xmax / 10
    for (i in 1:n) {
      if (is.finite(lower[i])) {
        if (is.finite(upper[i]))
          nbd[i] <- 2
        else {
          nbd[i] <- 1
          upper[i] <- bigval
        }
      }
      else {
        if (is.finite(upper[i])) {
          nbd[i] <- 3
          lower[i] <- -bigval
        }
        else {
          nbd[i] <- 0
          upper[i] <- bigval
          lower[i] <- -bigval
        }
      }
    }
    itask <- 2L
    task <- tasklist[itask]
    f <- .Machine$double.xmax / 100
    g <- rep(f, n)
    icsave <- 0
    repeat {
      if (isave[34] > ctrl$maxit)
        break
      
      if (ctrl$trace >= 2) {
        cat("Before call, f=", f, "  task number ", itask,
            " ")
        print(task)
      }
      result <-
        .Fortran(
          "lbfgsb3", n = as.integer(n), m = as.integer(m),
          x = as.double(prm), l = as.double(lower), u = as.double(upper),
          nbd = as.integer(nbd), f = as.double(f), g = as.double(g),
          factr = as.double(factr), pgtol = as.double(pgtol),
          wa = as.double(wa), iwa = as.integer(iwa), itask = as.integer(itask),
          iprint = as.integer(iprint), icsave = as.integer(icsave),
          lsave = as.logical(lsave), isave = as.integer(isave),
          dsave = as.double(dsave)
        )
      itask <- result$itask
      icsave <- result$icsave
      prm <- result$x
      g <- result$g
      iwa <- result$iwa
      wa <- result$wa
      nbd <- result$nbd
      lsave <- result$lsave
      isave <- result$isave
      dsave <- result$dsave
      if (ctrl$trace > 2) {
        cat("returned from lbfgsb3\n")
        cat("returned itask is ", itask, "\n")
        task <- tasklist[itask]
        cat("changed task to ", task, "\n")
      }
      if (itask %in% c(4L, 20L, 21L)) {
        if (ctrl$trace >= 2) {
          cat("computing f and g at prm=")
          print(prm)
        }
        f <- fn(prm, ...)
        if (is.null(gr)) {
          g <- grad(fn, prm, ...)
        }
        else {
          g <- gr(prm, ...)
        }
        if (ctrl$trace > 0) {
          cat("At iteration ", isave[34], " f =", f)
          if (ctrl$trace > 1) {
            cat("max(abs(g))=", max(abs(g)))
          }
          cat("\n")
        }
      }
      else {
        if (itask == 1L) {
          
        }
        else
          break
      }
    }
    info <- list(
      task = task, itask = itask, lsave = lsave,
      icsave = icsave, dsave = dsave, isave = isave
    )
    ans <- list(prm = prm, f = f, g = g, info = info)
  }
