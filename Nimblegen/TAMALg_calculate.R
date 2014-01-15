tamalg = function(L = 380000, P_value = 0.0001, p = 0.02){
	sigma = log(1/p);
	m_Rn = log(L ,base = 1/p) + 0.577/sigma -0.5;
	v_Rn = pi^2/(6*sigma^2) + 1/12;
	SD = v_Rn^0.5;
	z = ( -0.577 - log(log(1/(1-P_value))))/1.2825;
	w = z*SD + m_Rn;
	return (w);
}