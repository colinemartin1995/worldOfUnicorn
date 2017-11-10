#ifndef CALCUL_H
#define CALCUL_H

#include <QObject>

#include <QRect>

class Calcul : public QObject
{
    Q_OBJECT
public:
    explicit Calcul(QObject *parent = nullptr);

signals:

public slots:
    bool intersects( const QRect& rect1, const QRect& rect2 ){
        return rect1.intersects(rect2);
    }
};


#endif // CALCUL_H
