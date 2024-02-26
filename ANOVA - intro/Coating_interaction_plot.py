from matplotlib import pyplot as plt

lsmeans = {
    ('1', '1'): 4.66,  # LSMeans for B=1, C=1
    ('1', '2'): 4.465,  # LSMeans for B=1, C=2
    ('2', '1'): 4.75,  # LSMeans for B=2, C=1
    ('2', '2'): 8.0925   # LSMeans for B=2, C=2
}

B1_means = [lsmeans[('1', '1')], lsmeans[('1', '2')]]
B2_means = [lsmeans[('2', '1')], lsmeans[('2', '2')]]
C_levels = ['1', '2']

plt.figure(figsize=(8, 5))
plt.plot(C_levels, B1_means, marker='o', label='Factor B Level 1')
plt.plot(C_levels, B2_means, marker='o', label='Factor B Level 2')
plt.xlabel('Factor C Level')
plt.ylabel('Porosity LSMeans')
plt.title('Interaction Plot for B*C')
plt.legend()
plt.show()
