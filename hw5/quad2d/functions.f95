
module functions

    use omp_lib
    implicit none
    integer :: fevals(0:7), gevals(0:7)
    real(kind=8) :: k
    save

contains

    real(kind=8) function f(x)
        implicit none
        real(kind=8), intent(in) :: x
        real(kind=8) :: a, b
        integer thread_num, ny

        ! keep track of number of function evaluations by
        ! each thread:
        a = 1.
        b = 4.
        ny = 1000
        thread_num = 0   ! serial mode
        !$ thread_num = omp_get_thread_num()
        fevals(thread_num) = fevals(thread_num) + 1
        
        f = trapezoid(g, a, b, ny, x)
        
    end function f

    real(kind=8) function g(x,y)
        implicit none
        real(kind=8), intent(in) :: x, y 
        integer thread_num

        ! keep track of number of function evaluations by
        ! each thread:
        thread_num = 0   ! serial mode
        !$ thread_num = omp_get_thread_num()
        gevals(thread_num) = gevals(thread_num) + 1
        
        g = sin(x + y) 
        
    end function g



    real(kind=8) function trapezoid(g, a, b, n, x)

    ! Estimate the integral of f(x) from a to b using the
    ! Trapezoid Rule with n points.

    ! Input:
    !   f:  the function to integrate
    !   a:  left endpoint
    !   b:  right endpoint
    !   n:  number of points to use
    ! Returns:
    !   the estimate of the integral
     
    implicit none
    interface
        real(kind=8) function g(x,y)
        implicit none
        real(kind=8), intent(in) :: x, y
        end function g
    end interface
    real(kind=8), intent(in) :: a, b, x
    integer, intent(in) :: n

    ! Local variables:
    integer :: j
    real(kind=8) :: h, trap_sum, xj

    h = (b-a)/(n-1)
    trap_sum = 0.5*(g(x,a) + g(x,b))  ! endpoint contributions
    
    ! !$omp parallel do private(xj) reduction(+ : trap_sum) 
    do j=2,n-1
        xj = a + (j-1)*h
        trap_sum = trap_sum + g(x,xj)
    enddo

    trapezoid = h * trap_sum

end function trapezoid





end module functions
