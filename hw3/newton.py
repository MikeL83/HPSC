"""

Newton.py


"""

def fvals_sqrt(x):
	"""
	Return f(x) and f'(x) for applying Newton to find a
	square root.
	"""
	f = x**2 - 4.
	fp = 2.*x

	return f, fp


def solve(fvals,x0,debug_solve=False):
	maxiter = 20
	xold = x0
	xk = x0
	if (debug_solve):
		print "Initial quess: x = %22.15e" % x0
	for k in xrange(1,maxiter + 1):
		f, fp = fvals(xold)
		if (abs(f) < 1e-14):
			break
		xk = xold - f/fp
		if (debug_solve):
			print "After %d iterations, x = %22.15e" % (k,xk)
		xold = xk

	return xk, k


def test1(debug_solve=False):
	"""
	Test Newton iteration for the square root with different initial
	conditions.
	"""
	from numpy import sqrt
	for x0 in [1., 2., 100.]:
		print " "
		x, iters = solve(fvals_sqrt, x0, debug_solve)
		print "solve returns x = %22.15e after %d iterations " % (x,iters)
		fx,fpx = fvals_sqrt(x)
		print "the value of f(x) is %22.15e" % fx
		#assert abs(x-2.) < 1e-14, "*** Unexpected result: x = %22.15e" % x


if __name__ == "__main__":

	print "Running..."
	test1()

