import psycopg2

connection = psycopg2.connect(user="jf58",
                              password="jf58sc122",
                              host="ricedb-jf58sc122.czhrx2sig5fp.us-east-1.rds.amazonaws.com",
                              port="5432",
                              database="jf58sc122")
cur = connection.cursor()
inputFile = ("C:/Users/jason/Desktop/19fall MCS/COMP 533/projects/new data/fifaa.csv")
with open(inputFile, encoding="utf8") as fr:
    data = fr.readlines()
for i in range(1, len(data)):
    line = data[i].split(",")
    idd = int(line[0])
    print(idd)
    name = line[1]
    # print(name)
    full = line[2]
    # print(full)
    if line[3] == "":
        birth = None
    else:
        birth = line[3]
    # print(birth)
    if line[4] == "":
        age = None
    else:
        age = int(line[4])
    # print(age)
    if line[5] == "":
        height = None
    else:
        height = float(line[5])
    # print(height)
    if line[6] == "":
        weight = None
    else:
        weight = float(line[6])
    # print(weight)
    m = 7
    position = ""
    if line[m] == "":
        position = line[m] + ","
    else:
        if line[m][0] != "\"":
            position = "\"" + line[m] + "\""
        else:
            while True:
                position += line[m] + ","
                if line[m][len(line[m]) - 1] == "\"":
                    break
                m = m + 1
    position[:-1]
    nation = line[m + 1]
    if line[m+2] == "":
        rating = None
    else:
        rating = float(line[m + 2])
    if line[m+3] == "":
        potential = None
    else:
        potential = float(line[m + 3])
    if line[m+4] == "":
       value = None
    else:
       value = float(line[m + 4])
    if line[m+5] == "":
        wage = None
    else:
        wage = float(line[m + 5])
    foot = line[m + 6]
    if line[m+6+1] == "":
        reputation = None
    else:
        reputation = float(line[m + 6 + 1])
    if line[m+7+1] == "":
        weakfoot = None
    else:
        weakfoot = float(line[m + 7 + 1])
    if line[m+8+1] == "":
        skillmove = None
    else:
        skillmove = float(line[m + 8 + 1])
    workrate = line[m + 9 + 1]
    bodytype = line[m + 10 + 1]
    if line[m+11+1] == "":
        release = None
    else:
        release = float(line[m + 11 + 1])
    club = line[m + 12 + 1]
    if line[m+13+1] == "":
        clubrate = None
    else:
        clubrate = float(line[m + 13 + 1])
    clubposition = line[m + 14 + 1]
    if line[m+15+1] == "":
        clubnumber = None
    else:
        clubnumber = int(line[m + 15 + 1])
    if line[m+16+1] == "":
        clubjoin = None
    else:
        clubjoin = line[m + 16 + 1]
    endyear = line[m + 17 + 1]
    nationalteam = line[m + 18 + 1]
    if line[m+19+1] == "":
        nationalrate = None
    else:
        nationalrate = float(line[m + 19 + 1])
    nationalpostion = line[m + 20 + 1]
    if line[m+21+1] == "":
        nationalnumber = None
    else:
        nationalnumber = int(line[m + 21 + 1])
    # print(nationalnumber)
    att = [0 for i in range(30 + 1, 64 + 1)]
    q = 0
    for n in range(m + 22 + 1, m + 57):
        if line[n] == "":
            att[q] = None
        else:
            att[q] = float(line[n])
        q = q + 1
    print("-------------------")
    query = "INSERT INTO player_update VALUES (%s, %s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s, %s,%s,%s, %s,%s,%s, %s,%s);"
    data_insert = (idd, name,full,birth,age,height,weight,position,nation,rating,potential,value,wage,foot,reputation,weakfoot,skillmove,workrate,bodytype,release,club,clubrate,clubposition,clubnumber,clubjoin,endyear,nationalteam,nationalrate,nationalpostion,nationalnumber,att[0],att[1],att[2],att[3],att[4],att[5],att[6],att[7],att[8],att[9],att[10],att[11],att[12],att[13],att[14],att[15],att[16],att[17],att[18],att[19],att[20],att[21],att[22],att[23],att[24],att[25],att[26],att[27],att[28],att[29],att[30],att[31],att[32],att[33])
    cur.execute(query, data_insert)
    connection.commit()
# Close the cursor and connection to so the server can allocate
# bandwidth to other requests
cur.close()
connection.close()
