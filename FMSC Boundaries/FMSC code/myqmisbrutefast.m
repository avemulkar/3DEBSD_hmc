function mis = myqmisbrutefast(qa,qb)
CS = symmetry('triclinic');
qa = quaternion(qa(1),qa(2),qa(3),qa(4));
qb = quaternion(qb(1),qb(2),qb(3),qb(4));
mis = angle_outer(qa,qb)
mis = angle(qa,qb)