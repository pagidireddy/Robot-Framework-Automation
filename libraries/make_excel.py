import pandas as pd


def pd_excel_file(file_name, elements):
    df = pd.DataFrame(elements)
    df.to_excel(file_name, index=False)
