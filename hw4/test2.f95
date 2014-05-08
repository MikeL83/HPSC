
program test2

    use quadrature

    implicit none
    real(kind=8) :: a, b, int_true, a2, b2
    integer :: nvals(12), i, k

    a = 0.0
    b = 2.0
    a2 = 0.0
    b2 = 2.0
    k = 1000
    int_true = (b2-a2) + (b2**4 - a2**4) / 4.0 - (1.0/k) * &
                (cos(k*b2) - cos(k*a2))

    print 10, int_true
 10 format("true integral: ", es22.14)
    print *, " "  ! blank line

    ! values of n to test:
    do i = 1, size(nvals)
        nvals(i) = 5 * 2**(i-1)
    enddo
    
    call error_table(f, a, b, nvals, int_true)

contains

    real(kind=8) function f(x)
        implicit none
        real(kind=8), intent(in) :: x

        f = 1.0 + x**3 + sin(k*x)
    end function f

end program test2
