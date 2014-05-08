! $UWHPSC/codes/fortran/newton/test1.f90

program main

    use newton, only: solve
    use functions, only: g_fcn, gp_fcn

    implicit none
    real(kind=8) :: x, x0, gx
    real(kind=8) :: x0vals(4)
    integer :: iters, itest
    logical :: debug         ! set to .true. or .false.

    print *, "Test routine for computing zero of g"
    debug = .true.

    ! values to test as x0:
    x0vals = (/-2.5, -1.5, -0.5, 1.5/)

    do itest = 1, 4
        x0 = x0vals(itest)
        print *, ' '  ! blank line
        call solve(g_fcn, gp_fcn, x0, x, iters, debug)

        print 11, x, iters
11      format('solver returns x = ', e22.15, ' after', i3, ' iterations')

        gx = g_fcn(x)
        print 12, gx
12      format('the value of f(x) is ', e22.15)

        if (abs(x-2.d0) > 1d-14) then
            print 13, x
13          format('*** Unexpected result: x = ', e22.15)
            endif
        enddo

end program main
