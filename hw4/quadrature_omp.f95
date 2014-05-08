! quadrature

module quadrature_omp
    use omp_lib
contains

subroutine error_table(func, a, b, nvals, int_true)
    implicit none
    interface
        real(kind=8) function func(x)
            implicit none
            real(kind=8), intent(in) :: x
        end function func
    end interface
    real(kind=8), intent(in) :: a, b, int_true
    integer, dimension(:), intent(in) :: nvals
    real(kind=8) :: last_error, ratio, error, int_trap
    integer :: k, n

    last_error = 0.0
    write(*,'(8X,A,8X,A,16X,A,8X,A)') 'n','trapezoid','error','ratio'

    do k = 1, size(nvals)
        n = nvals(k)
        int_trap = trapezoid(func, a, b, n)
        error = abs(int_trap - int_true)
        ratio = last_error / error
        last_error = error
        write(*,'(I8,4X,E22.14,4X,E10.3,4X,E10.3)') n, int_trap, error, ratio
    end do

end subroutine error_table

real(kind=8) function trapezoid(func,a,b,n) result(int_trapz)
    use omp_lib
    implicit none
    interface
        real(kind=8) function func(xi)
            implicit none
            real(kind=8), intent(in) :: xi
        end function func
    end interface
    real(kind=8), intent(in) :: a, b
    integer, intent(in) :: n
    real(kind=8) :: h
    real(kind=8), allocatable :: xj(:), fj(:)
    integer :: alloc_stat, k, nthreads
    
    allocate(xj(n), stat=alloc_stat)
    if (alloc_stat /= 0) call exit()

    allocate(fj(n), stat=alloc_stat)
    if (alloc_stat /= 0) call exit()

    h = (b - a)/(n - 1)

    xj = makelinspace(a,b,n)

    !$ call omp_set_num_threads(8)
    !$omp parallel do
    do k = 1, n
        fj(k) = func(xj(k))
    end do
    !$omp end parallel do

    int_trapz = h*sum(fj) - 0.5*h*(fj(1) + fj(size(fj)))  

    deallocate(xj, fj)

end function trapezoid


    
function makelinspace(a,b,n) result(linvector)
    real(kind=8), intent(in) :: a, b
    integer, intent(in) :: n
    real(kind=8) :: h, linvector(n)
    integer :: j
    h = (b - a) / real((n - 1))
    linvector(1) = a
    linvector(n) = b
    forall(j = 2:n-1) linvector(j) = a + (j-1)*h
end function makelinspace


end module quadrature_omp
