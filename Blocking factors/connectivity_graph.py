import pandas as pd
import networkx as nx
import matplotlib.pyplot as plt

data_design1 = {
    'Block': [1, 2, 3, 4, 5, 6],
    'Treatment1': [1, 1, 1, 2, 2, 3],
    'Treatment2': [2, 3, 4, 3, 4, 4]
}

data_design2 = {
    'Block': [1, 2, 3, 4, 5, 6, 7, 8, 9],
    'Treatment1': [1, 4, 7, 1, 2, 3, 1, 2, 3],
    'Treatment2': [2, 5, 8, 4, 5, 6, 5, 6, 4],
    'Treatment3': [3, 6, 9, 7, 8, 9, 9,7, 8]
}

data_design3 = {
    'Block': [1, 2, 3, 4, 5, 6, 7, 8],
    'Treatment1': [1, 3, 2, 4, 1, 3, 1, 3],
    'Treatment2': [2, 4, 6, 5, 6, 5, 2, 4],
    'Treatment3': [6, 5, 8, 7, 8, 7, 8, 7]
}

def add_edges_multi_treatments(G, df):
    for _, row in df.iterrows():
        block = row['Block']
        for treatment in row.index[row.index.str.startswith('Treatment')]:
            G.add_node(row[treatment])
            G.add_edge(block, row[treatment])
    return G

G1 = nx.Graph()
G2 = nx.Graph()
G3 = nx.Graph()
df_design1 = pd.DataFrame(data_design1)
df_design2 = pd.DataFrame(data_design2)
df_design3 = pd.DataFrame(data_design3)

G1 = add_edges_multi_treatments(G1, df_design1)
G2 = add_edges_multi_treatments(G2, df_design2)
G3 = add_edges_multi_treatments(G3, df_design3)

# Plotting function
def plot_graph(G, title):
    plt.figure(figsize=(8, 6))
    pos = nx.spring_layout(G)
    nx.draw(G, pos, with_labels=True, node_color='lightblue', font_weight='bold', node_size=2000, font_size=16)
    plt.title(title)
    plt.show()

# Plot each design
plot_graph(G1, 'Connectivity Graph for Design I')
plot_graph(G2, 'Connectivity Graph for Design II')
plot_graph(G3, 'Connectivity Graph for Design III')