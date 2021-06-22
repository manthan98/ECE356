from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split, KFold, GridSearchCV
from sklearn.metrics import confusion_matrix, plot_confusion_matrix, classification_report, accuracy_score
from sklearn import tree
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

task_a_csv = "/Users/manthanshah/Desktop/output_task_a.csv"
task_b_csv = "/Users/manthanshah/Desktop/output_task_b.csv"

df_a = pd.read_csv(task_a_csv)
df_b = pd.read_csv(task_b_csv)

# df is dataframe representing csv
y_a = df_a["class"]
y_b = df_b["class"]

del df_a['playerID'] # drop strings
del df_a['class'] # drop label

del df_b['playerID']
del df_b['class']

# Data cleansing
X_a = df_a.fillna(0)
X_b = df_b.fillna(0)

X_a_train, X_a_test, y_a_train, y_a_test = train_test_split(X_a, y_a, test_size=0.2)
X_b_train, X_b_test, y_b_train, y_b_test = train_test_split(X_b, y_b, test_size=0.2)

clf_a = tree.DecisionTreeClassifier()
clf_b = tree.DecisionTreeClassifier()

hyperparams = False
if hyperparams:
    max_depths = np.arange(5,20)
    min_impurities = np.arange(0.0, 0.005, 0.00002)

    grid_a = GridSearchCV(estimator=clf_a, param_grid=dict(max_depth=max_depths, min_impurity_decrease=min_impurities))
    grid_b = GridSearchCV(estimator=clf_b, param_grid=dict(max_depth=max_depths, min_impurity_decrease=min_impurities))

    grid_a = grid_a.fit(X_a_train, y_a_train)
    grid_b = grid_b.fit(X_b_train, y_b_train)

    clf_a = grid_a.best_estimator_
    clf_b = grid_b.best_estimator_

    # Training accuracy
    y_a_train_pred = clf_a.predict(X_a_train)
    y_b_train_pred = clf_b.predict(X_b_train)

    # Testing accuracy
    y_a_pred = clf_a.predict(X_a_test)

    print("\nTASK A:")
    print("Best Score: ", grid_a.best_score_)
    print("Best Params: ", grid_a.best_params_)
    print("Depth: ", clf_a.get_depth())
    print("Training:\n", classification_report(y_a_train, y_a_train_pred))
    print("Testing:\n", classification_report(y_a_test, y_a_pred))
    print(confusion_matrix(y_a_test, y_a_pred))

    y_b_pred = clf_b.predict(X_b_test)
    print("\nTASK B:")
    print("Best Score: ", grid_b.best_score_)
    print("Best Params: ", grid_b.best_params_)
    print("Depth: ", clf_b.get_depth())
    print("Training:\n", classification_report(y_b_train, y_b_train_pred))
    print("Testing:\n", classification_report(y_b_test, y_b_pred))
    print(confusion_matrix(y_b_test, y_b_pred))
else:
    clf_a = clf_a.fit(X_a_train, y_a_train)
    clf_b = clf_b.fit(X_b_train, y_b_train)

    # Training accuracy
    y_a_train_pred = clf_a.predict(X_a_train)
    y_b_train_pred = clf_b.predict(X_b_train)

    # Testing accuracy
    y_a_pred = clf_a.predict(X_a_test)
    y_b_pred = clf_b.predict(X_b_test)

    print("\nTASK A:")
    print("Depth: ", clf_a.get_depth())
    print("Training:\n", classification_report(y_a_train, y_a_train_pred))
    print("Testing:\n", classification_report(y_a_test, y_a_pred))
    print("Confusion: \n", confusion_matrix(y_a_test, y_a_pred))

    print("\nTASK B:")
    print("Depth: ", clf_b.get_depth())
    print("Training:\n", classification_report(y_b_train, y_b_train_pred))
    print("Testing:\n", classification_report(y_b_test, y_b_pred))
    print("Confusion: \n", confusion_matrix(y_b_test, y_b_pred))

save_trees = False
if save_trees:
    fig = plt.figure(figsize=(100,100))
    _ = tree.plot_tree(clf_a)
    fig.savefig("decision_tree_a.png")

    fig = plt.figure(figsize=(100,100))
    _ = tree.plot_tree(clf_b)
    fig.savefig("decision_tree_b.png")



