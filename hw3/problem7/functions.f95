! $UWHPSC/codes/fortran/newton/functions.f90

module functions

    ! module parameters:
    implicit none
    real(kind=8), save :: eps = 1e2*EPSILON(1.0)
    public :: eps

contains

real(kind=8) function f_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x

    f_sqrt = x**2 - 4.0

end function f_sqrt


real(kind=8) function fprime_sqrt(x)
    implicit none
    real(kind=8), intent(in) :: x
    
    fprime_sqrt = 2.0 * x

end function fprime_sqrt

real(kind=8) function g_fcn(x)
     implicit none
     real(kind=8), intent(in) :: x 
    
     g_fcn = x*cos(acos(-1.0)*x) - (1.0 - 0.6*x**2)

end function g_fcn

real(kind=8) function gp_fcn(x)
    implicit none
    real(kind=8), intent(in) :: x
    
    gp_fcn = -acos(-1.0)*x*sin(acos(-1.0)*x) + cos(acos(-1.0)*x) + 1.2*x

end function gp_fcn

real(kind=8) function f_quartic(x)
    implicit none
    real(kind=8), intent(in) :: x

    f_quartic = (x - 1)**4 - eps
    end function f_quartic

real(kind=8) function fprime_quartic(x)
    implicit none
    real(kind=8), intent(in) :: x

    fprime_quartic = 4*(x - 1)**3
    end function fprime_quartic





end module functions
