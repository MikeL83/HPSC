! $UWHPSC/codes/fortran/newton/test1.f90

program main

    use newton, only: solve, tol
    use functions, only: eps, f_quartic, fprime_quartic

    implicit none
    real(kind=8) :: x, fx, xstar
    real(kind=8), parameter :: x0 = 4.0
    real(kind=8) :: tols(3)
    real(kind=8) :: epsilons(5)
    integer :: iters, itol, ieps
    logical :: debug         ! set to .true. or .false.

    print 8, 'Starting with initial guess ',x0 
8   format(A,es22.15)
    print *, ' '
    debug = .true.

    ! values to test as x0:
    !x0vals = (/4.0/)
    tols = (/1.e-5, 1.e-10, 1.e-14/)
    epsilons = (/1e-2, 1e-4, 1e-8, 1e-12, 1e-16/)
    print *, '      epsilon         tol     iters       x               f(x)            x-xstar'

    do ieps = 1, 5
        !x0 = x0vals(itest)
        eps = epsilons(ieps)
        print *, ' '  ! blank line
        do itol = 1, 3
            tol = tols(itol) 
            call solve(f_quartic, fprime_quartic, x0, x, iters, debug)
            fx = f_quartic(x) 
            xstar = abs(x - (1 + eps**(0.25)))
            print 11, eps, tol, iters, x, fx, xstar 
11          format(2es13.3, i4, es24.15, 2es13.3)
        enddo
    enddo

end program main
