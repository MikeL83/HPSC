"""

Newton.py


"""

from newton import solve
from numpy import sin, cos, pi, array, asarray, r_
import matplotlib.pyplot as plt

def g1_fcn(x):
	"""
	Return g1(x) and g1'(x) functions
	"""
	g = x*cos(pi*x)
	gp = -pi*x*sin(pi*x) + cos(pi*x)

	return g, gp

def g2_fcn(x):
        """
	Return g2(x) and g2'(x) functions
	"""

	g = 1 - 0.6*x**2
	gp = -1.2*x

	return g, gp

def g_fcns(x):

	g1, g1p = g1_fcn(x)
	g2, g2p = g2_fcn(x)
	g = g1 - g2
	gp = g1p - g2p

	return g, gp

"""
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
"""

def plot_fcns(intersecs):
	x = r_[-5:6:1]
	print intersecs
	g1,g1p = g1_fcn(x)
	g2,g2p = g2_fcn(x)
	g_inter, g_interp = g1_fcn(intersecs)
	plt.plot(x,g1,'b-',x,g2,"r:",intersecs,g_inter,'ko')
	plt.legend(('g1','g2'),'lower right')
	plt.show()

def test1(debug_solve=False):
	"""
	Test Newton iteration for the square root with different initial
	conditions.
	"""
	is_values = []
	for x0 in [-2.5,-1.5,-0.5,1.5]:
		print " "
		x, iters = solve(g_fcns, x0, debug_solve)
		print "solve returns x = %22.15e after %d iterations " % (x,iters)
		fx,fpx = g_fcns(x)
		print "the value of f(x) is %22.15e" % fx
		is_values.append(x)
		#assert abs(x-2.) < 1e-14, "*** Unexpected result: x = %22.15e" % x
	plot_fcns(asarray(is_values))

if __name__ == "__main__":
	print "Testing..."
	test1()








